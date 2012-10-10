# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121010220154) do

  create_table "bills", :force => true do |t|
    t.string   "csv"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "calls", :force => true do |t|
    t.integer  "bill_id"
    t.string   "source"
    t.string   "destination"
    t.integer  "duration"
    t.decimal  "cost",        :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.date     "date"
    t.time     "time"
  end

  add_index "calls", ["bill_id"], :name => "index_calls_on_bill_id"

  create_table "invalid_calls", :force => true do |t|
    t.string   "source"
    t.string   "destination"
    t.string   "date"
    t.string   "time"
    t.string   "duration"
    t.string   "cost"
    t.string   "error_messages"
    t.integer  "lineno"
    t.string   "csv_source"
    t.integer  "bill_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
