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

- has_many :items
- has_many :shipping_addresses, through: :items


## items テーブル

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

- belongs_to :user
- has_one :shipping_address


## shipping_addresses テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| prefecture         | string     | null: false                    |
| municipality       | string     | null: false                    |
| building_name      | text       | null: false                    |
| tell_number        | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
