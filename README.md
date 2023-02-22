# テーブル設計

## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false               |
| email                 | string  | null: false, unique: true |
| password              | string  | null: false               |
| password_confirmation | string  | null: false               |
| family_name           | string  | null: false               |
| first_name            | string  | null: false               |
| kana_family_name      | string  | null: false               |
| kana_first_name       | string  | null: false               |
| birthday_year         | integer | null: false               |
| birthday_month        | integer | null: false               |
| birthday_date         | integer | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| goods         | string     | null: false                    |
| content       | text       | null: false                    |
| category      | string     | null: false                    |
| condition     | string     | null: false                    |
| postage       | string     | null: false                    |
| place         | string     | null: false                    |
| delivery_days | integer    | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- hus_one    :order


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postcode     | string     | null:false                     |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| street       | string     | null:false                     |
| building     | string     |                                |
| phone_number | integer    | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order