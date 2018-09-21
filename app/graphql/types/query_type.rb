module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String,
        null: false,
                  description: "An example field added by the generator　XYZ"do
      argument :name, String, required: true
    end
    def test_field(name:)
      Rails.logger.info context[:time]
      "Hello #{name}!"
    end

    field :author, Types::AuthorType,
        null: true, description: "One Author" do
      argument :id, ID, required: true
    end

    def author(id:)
      Author.where(id: id).first
    end

    field :authors, [Types::AuthorType], null: false

    def authors
      Author.all
    end

    # ログインに失敗した時のことを考えて、nullを許可
    field :login, String, null: true, description: "Login a user_type.rb" do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    def login(email:, password:)
      if user = User.where(email: email).first&.authenticate(password)
        # ログインに成功したら、sessionのkeyを返す
        user.sessions.create.key
      end
    end

    # 現在ログインしているcurrent_userを定義
    field :current_user, Types::UserType, null: false, description: "The currently logged user_type.rb"

    def current_user
      context[:current_user]
    end

    # ログアウトの定義
    field :logout, Boolean, null: false

    def logout
      # 現在ログインしているユーザーのsession_idを探して、destroy_allすることでログアウトを実行
      Session.where(id: context[:session_id]).destroy_all
      # ログアウトに成功したらtrueを返す
      true
    end
  end
end
