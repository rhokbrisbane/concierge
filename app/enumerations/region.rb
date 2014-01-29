class Region < EnumerateIt::Base
  associate_values(
    :local,
    :state_provincial,
    :national
  )
end
