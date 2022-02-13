# README

# テーブル設計

## users テーブル

| Column                | Type   | Options                       |
| --------------------- | ------ | ----------------------------- |
| nickname              | string | null: false                   |
| email                 | string | null: false, unique_key: true |
| encrypted_password    | string | null: false                   |
| last_name             | string | null: false                   |
| first_name            | string | null: false                   |
| last_name_katakana    | string | null: false                   |
| first_name_katakana   | string | null: false                   |
| birthday              | date   | null: false                   |

### Association

- has_many :items
- has_many :purchases


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| item_condition_id  | integer    | null: false                    |
| area_id            | integer    | null: false                    |
| price              | integer    | null: false                    |
| delivery_cost_id   | integer    | null: false                    |
| days_to_ship_id    | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase


## purchases テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |
| shipping_address   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_adress


## shipping_addresses テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| area_id            | integer    | null: false                    |
| municipality       | string     | null: false                    |
| building_name      | string     |                                |
| tell_number        | string     | null: false                    |

### Association

- belongs_to :purchase
