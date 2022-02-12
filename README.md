# README

# テーブル設計

## users テーブル

| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| email              | string | null: false, unique_key: true |
| encrypted_password | string | null: false                   |
| last_name          | string | null: false                   |
| first_name         | string | null: false                   |
| nickname           | string | null: false                   |
| birthday           | string | null: false                   |

### Association

- has_many :prototype
- has_many :comments, through: :prototype


## item テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| description        | text       | null: false                    |
| category           | string     | null: false                    |
| item_condition     | text       | null: false                    |
| seller_area        | string     | null: false                    |
| price              | integer    | null: false, foreign_key: true |
| delivery_cost      | integer    | null: false, foreign_key: true |
| days_to_ship       | integer    | null: false, foreign_key: true |
| purchase_flag      | text       | null: false                    |

### Association

- belongs_to :users
- has_many :comments, through: :users


## shipping_address テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| prefecture         | string     | null: false                    |
| municipality       | string     | null: false                    |
| building_name      | text       | null: false                    |
| tell_number        | integer    | null: false                    |

### Association

- belongs_to :users
- has_many :comments, through: :users
