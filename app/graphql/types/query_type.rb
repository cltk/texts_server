Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :authors do
    type types[Types::AuthorType]

    argument :limit, types.Int, default_value: 20
    argument :offset, types.Int, default_value: 0

    description "List all authors"
    resolve -> (obj, args, ctx) { Author.limit(args[:limit]).offset(args[:offset]) }
  end

  field :authors_count do
    type types.Int

    description "Count authors"
    resolve -> (obj, args, ctx) { Author.count() }
  end

  field :author_by_id do
    type Types::AuthorType

    argument :id, !types.ID
    description "Find an author by its (integer) ID"
    resolve -> (obj, args, ctx) { Author.find(args[:id]) }
  end

  field :author_by_slug do
    type Types::AuthorType

    argument :slug, !types.String
    description "Find an author by its slug"
    resolve -> (obj, args, ctx) { Author.find_by(slug: args[:slug]) }
  end

  field :authors_count do
    type types.Int

    description "Count authors"
    resolve -> (obj, args, ctx) { Author.count }
  end

  field :corpora do
    type types[Types::CorpusType]

    description "List all corpora"
    resolve -> (obj, args, ctx) { Corpus.all }
  end

  field :corpus_by_id do
    type Types::CorpusType

    argument :id, !types.ID
    description "Find a corpus by its (integer) ID"
    resolve -> (obj, args, ctx) { Corpus.find(args[:id]) }
  end

  field :corpus_by_slug do
    type Types::CorpusType

    argument :slug, !types.String
    description "Find a corpus by its slug"
    resolve -> (obj, args, ctx) { Corpus.find_by(slug: args[:slug]) }
  end

  field :languages do
    type types[Types::LanguageType]

    description "List all languages"
    resolve -> (obj, args, ctx) { Language.all }
  end

  field :language_by_id do
    type Types::LanguageType

    argument :id, !types.ID
    description "Find a language by its (integer) ID"
    resolve -> (obj, args, ctx) { Language.find(args[:id]) }
  end

  field :language_by_slug do
    type Types::LanguageType

    argument :slug, !types.String
    description "Find a language by its slug"
    resolve -> (obj, args, ctx) { Language.find_by(slug: args[:slug]) }
  end

  field :works do
    type types[Types::WorkType]

    argument :limit, types.Int, default_value: 20
    argument :offset, types.Int, default_value: 0

    description "List all works"
    resolve -> (obj, args, ctx) { Work.limit(args[:limit]).offset(args[:offset]) }
  end

  field :works_count do
    type types.Int

    description "Count works"
    resolve -> (obj, args, ctx) { Work.count() }
  end

  field :work_by_id do
    type Types::WorkType

    argument :id, !types.ID
    description "Find a work by its (integer) ID"
    resolve -> (obj, args, ctx) { Work.find(args[:id]) }
  end

  field :work_by_slug do
    type Types::WorkType

    argument :slug, !types.String
    description "Find a work by its slug"
    resolve -> (obj, args, ctx) { Work.find_by(slug: args[:slug]) }
  end

  field :works_count do
    type types.Int

    description "Count works"
    resolve -> (obj, args, ctx) { Work.count }
  end

  field :works do
    type types[Types::WorkType]

    argument :limit, types.Int, default_value: 20
    argument :offset, types.Int, default_value: 0

    description "List all works"
    resolve -> (obj, args, ctx) { Work.limit(args[:limit]).offset(args[:offset]) }
  end
end
