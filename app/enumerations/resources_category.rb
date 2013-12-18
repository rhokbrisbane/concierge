class ResourcesCategory < EnumerateIt::Base
  associate_values(
    :advocacy,
    :community_centre,
    :counselling,
    :info,
    :disability_and_chronic_illness,
    :education,
    :equipment,
    :funding
  )
end
