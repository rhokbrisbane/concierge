class RenameResourceCategoryIdColumnFromResources < ActiveRecord::Migration
  def up
    create_initial_categories if ResourceCategory.count.zero?

    add_column :resources, :resource_category_id, :integer

    Resource.all.each do |resource|
      old_category_name = resource.read_attribute(:category)

      new_category_name = case old_category_name
        when 'advocacy'                       then 'Advocacy'
        when 'community_centre'               then 'Community Centre'
        when 'counselling'                    then 'Counselling'
        when 'info'                           then 'Info'
        when 'disability_and_chronic_illness' then 'Disability & Chronic Illness'
        when 'education'                      then 'Education'
        when 'equipment'                      then 'Equipment'
        when 'funding'                        then 'Funding'
        when 'other'                          then 'Other'
      end

      resource.update resource_category_id: ResourceCategory.find_by_name(new_category_name).id
    end

    remove_column :resources, :category
  end

  def down
    add_column :resources, :category, :string

    Resource.all.each do |resource|
      resource.update_column :category, resource.resource_category.name
    end

    remove_column :resources, :resource_category_id
  end

  private

  def create_initial_categories
    resource_categories = [
      'Advocacy',
      'Community Centre',
      'Counselling',
      'Info',
      'Disability & Chronic Illness',
      'Education',
      'Equipment',
      'Funding',
      'Other'
    ]

    resource_categories.each { |name| ResourceCategory.create(name: name) }
  end
end
