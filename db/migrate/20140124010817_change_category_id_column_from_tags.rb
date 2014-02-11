# Using SQL in this migration because the models had its names changed.
class ChangeCategoryIdColumnFromTags < ActiveRecord::Migration
  def up
    create_initial_categories if connection.execute('select count(*) from categories').to_a.first['count'].to_i.zero?

    add_column :tags, :category_id, :integer

    Tag.all.each do |tag|
      old_category_name = tag.read_attribute(:category)

      new_category_name = case old_category_name
        when 'needs'        then 'Needs'
        when 'symptoms'     then 'Symptoms'
        when 'age_group'    then 'Age group'
        when 'weight_group' then 'Weight group'
      end

      category_id = connection.execute("select id from categories where name='#{new_category_name}'").to_a.first['id'].to_i
      tag.update category_id: category_id
    end

    remove_column :tags, :category
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def create_initial_categories
    ['Needs', 'Symptoms', 'Age group', 'Weight group'].each do |category_name|
      connection.execute("INSERT INTO categories (name) VALUES ('#{category_name}')")
    end
  end
end
