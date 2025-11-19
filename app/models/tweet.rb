class Tweet < ApplicationRecord

    belongs_to :category, optional: true
    belongs_to :user, optional: true 
    mount_uploader :image, ImageUploader

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :tweet_tag_relations, dependent: :destroy
    #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
    has_many :tags, through: :tweet_tag_relations, dependent: :destroy
    # URL形式チェック（任意）
    validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true
    
end
