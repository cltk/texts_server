namespace :text_nodes do
  require 'json'
  require 'uri'

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

  def import_cltk_json(filename, repo)
    data = begin
      JSON.load(filename, nil, symbolize_names: true)
    rescue => exception
      puts "----- Failed to read #{filename}. ------"
      puts "#{exception}"
      return nil
    end

    work = data.get(:work) ||
           data.get(:english_title) ||
           data.get(:englishTitle) ||
           data.get(:title)

    return "------ broken file #{filename} ------" unless work

    original_title = data.get(:originalTitle) || data.get(:original_title) || work

    edition = data.get(:edition) || ""
    author = data.get(:author)
    structure = data.get(:meta).downcase || ""
    corpus = data.get(:source) || repo
      .replace("texts", "").replace("text", "")
      .replace(".git", "").replace("_", " ").strip.titleize
    corpus_link = data.get(:sourceLink) || make_corpus_link(corpus)
    language = data.get(:language).downcase
    language = "greek" if language == "grc"
    language = "german" if language == "ger"
    form = if structure.include?("line")
      "poetry"
    else
      "prose"
    end

    # ingest
  end

  task :ingest, [:repo] => :environment do |_, args|
    require 'tmpdir'

    repo = args[:repo]

    Dir.mktmpdir do |dir|
      dest = "#{dir}/texts"
      `git clone #{repo} #{dest}`

      Dir.each_child(dest) do |f|
        next unless File.extname(f) == ".json"

        import_cltk_json("#{dest}/#{f}", URI.parse(repo).path.split("/")[1:])
      end
    end
  end
end
