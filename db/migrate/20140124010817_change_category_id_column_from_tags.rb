class ChangeCategoryIdColumnFromTags < ActiveRecord::Migration
  def up
    create_initial_categories if Category.count.zero?

    add_column :tags, :category_id, :integer

    Tag.all.each do |tag|
      old_category_name = tag.read_attribute(:category)

      new_category_name = case old_category_name
        when 'needs'        then 'Needs'
        when 'symptoms'     then 'Symptoms'
        when 'age_group'    then 'Age group'
        when 'weight_group' then 'Weight group'
      end

      tag.update category_id: Category.find_by_name(new_category_name).id
    end

    remove_column :tags, :category
  end

  def down
    add_column :tags, :category, :string

    Tag.all.each do |tag|
      tag.update_column :category, Category.find(tag.category_id).name
    end

    remove_column :tags, :category_id
  end

  private

  def create_initial_categories
    ['Needs', 'Symptoms', 'Age group', 'Weight group'].each do |category_name|
      Category.create(name: category_name)
    end
  end
end
