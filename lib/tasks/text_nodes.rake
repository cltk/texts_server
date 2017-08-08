namespace :text_nodes do
  require 'json'
  require 'tmpdir'
  require 'uri'

  def format_text_nodes(text, nodes=[], location=[])
    text.each_with_index do |(k, v), i|
      _location = location + [k.to_s.to_i]

      next format_text_nodes(v, nodes, _location) if v.is_a?(Hash)

      nodes << {
        location: _location,
        text: v,
      }
    end

    nodes
  end

  def import_cltk_json(filename, repo)
    md5_hash = Digest::MD5.file(filename).hexdigest

    return "No changes necessary for #{filename}" if Work.where(md5_hash: md5_hash).any?

    data = begin
      JSON.load(File.new(filename), nil, create_additions: false, symbolize_names: true)
    rescue => exception
      puts "----- Failed to read #{filename}. ------"
      puts "#{exception}"
      return nil
    end

    work = data[:work] ||
           data[:english_title] ||
           data[:englishTitle] ||
           data[:title]

    return "------ broken file #{filename} ------" unless work

    original_title = data[:originalTitle] ||
                     data[:original_title] ||
                     work

    edition = data[:edition] || ""
    author = data[:author]
    structure = data[:meta].downcase || ""
    corpus = data[:source] ||
             repo
               .replace("texts", "")
               .replace("text", "")
               .replace(".git", "")
               .replace("_", " ")
               .strip
               .titleize
    corpus_link = data[:sourceLink] || make_corpus_link(corpus)
    language = data[:language].downcase
    language = "greek" if language == "grc"
    language = "german" if language == "ger"
    form = if structure.include?("line")
      "poetry"
    else
      "prose"
    end
    urn = data[:urn] || ""

    ingest({
      author: author,
      corpus: corpus,
      corpus_link: corpus_link,
      edition: edition,
      english_title: work,
      filename: filename,
      form: form,
      md5_hash: md5_hash,
      language: language,
      original_title: original_title,
      structure: structure,
      urn: urn,
    }, data)
  end

  def ingest(meta, data)
    language = Language.find_or_create_by(
      slug: slugify(meta[:language]),
      title: data[:language]
    )
    author = Author.find_or_create_by(
      language_id: language.id,
      name: meta[:author].titleize,
      slug: slugify(meta[:author])
    )
    corpus = Corpus.find_or_create_by(
      language_id: language.id,
      link: meta[:corpus_link],
      slug: slugify(meta[:corpus]),
      title: meta[:corpus].titleize
    )
    work = Work.find_or_initialize_by(
      author_id: author.id,
      corpus_id: corpus.id,
      language_id: language.id,
      slug: slugify(meta[:english_title])
    ) do |w|
      puts w
      w.edition = meta[:edition]
      w.english_title = meta[:english_title]
      w.filename = meta[:filename]
      w.form = meta[:form]
      w.md5_hash = meta[:md5_hash]
      w.original_title = meta[:original_title]
      w.structure = meta[:structure]
      w.urn = meta[:urn]
      w.save!
    end

    text_nodes = begin
      format_text_nodes(data.fetch(:text))
    rescue => exception
      puts "----- No `text` field in #{meta[:english_title]} -----"
      puts "#{exception}"

      return nil
    end

    text_nodes.each_with_index do |node, i|
      TextNode.find_or_create_by!(
        author_id: author.id,
        corpus_id: corpus.id,
        index: i,
        language_id: language.id,
        location: node[:location],
        text: node[:text],
        work_id: work.id
      )
    end
  end

  def make_corpus_link(corpus)
    if corpus.downcase == "open greek and latin"
      "https://github.com/OpenGreekAndLatin"
    elsif corpus.downcase == "the first 1k years of greek"
      "http://opengreekandlatin.github.io/First1KGreek/"
    elsif corpus.downcase == "perseus digital library"
      "http://www.perseus.tufts.edu/hopper/"
    else
      puts "----- No link for #{corpus}. -----"
      ""
    end
  end

  def slugify(s)
    # https://docs.djangoproject.com/en/1.11/_modules/django/utils/text/#slugify
    s.gsub(/[^\w\s-]/, '').downcase.strip.gsub(/[-\s]+/, '-')
  end

  task :ingest, [:repo] => :environment do |_, args|
    repo = args[:repo]

    puts "----- Cloning from #{repo} -----"

    Dir.mktmpdir do |dir|
      dest = "#{dir}/texts"
      `git clone #{repo} #{dest}`

      json_dir = "#{dest}/cltk_json"
      next unless Dir.exists?(json_dir)

      Dir.new(json_dir).each do |f|
        next unless File.extname(f) == ".json"

        puts "----- Reading #{json_dir}/#{f} -----"

        import_cltk_json("#{json_dir}/#{f}", URI.parse(repo).path.split("/")[2].sub(".git", ""))
      end
    end
  end
end
