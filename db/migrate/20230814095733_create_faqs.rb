class CreateFaqs < ActiveRecord::Migration[7.0]
  def change
    create_table :faqs do |t|
      t.text :question
      t.text :answer
      t.string :category

      t.timestamps
    end
  end
end
