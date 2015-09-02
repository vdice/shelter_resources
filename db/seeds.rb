resource_list = {
  'hygiene products' => ['toothbrush', 'hairbrush'],
  'linens' => ['blankets', 'towels'],
  'clothing' => ['pants', 'sweaters'],
  'media' => ['books', 'dvds'],
  'toys' => ['board games', 'squirt guns'],
  'food' => ['pizza', 'pasta']
}

resource_list.each() do |key, value|
  Resource.create({:name => key})
end

shelter_list = [
  ["City Team Ministries", "526 SE Grand Ave,Portland, OR 97214", "503-231-9334"],
  ["Portland Rescue Mission", "111 W Burnside St, Portland, OR 97209", "503-906-7690"],
  ["VETS (Veterans Emergency Transitional Shelter)", "30 Sw 2nd Ave., Portland, OR 97204", "503-239-1259"],
  ["Transition Projects TPI", "665 NW Hoyt St, Portland, OR 97209", "503-823-4930"],
  ["Salvation Army Female Emergency Shelter (SAFES)", "30 SW 2nd Ave, Portland, OR 97204", "503-227-0810"]
]

shelter_list.each() do |name, address, phone_number|
  new_shelter = Shelter.create({:name => name, :address => address, :phone_number => phone_number})

  Resource.all().each() do |resource|
    resource_list.fetch(resource.name()).each() do |item_name|
      Item.create({:name => item_name, :quantity => 0, :resource_id => resource.id(), :shelter_id => new_shelter.id()})
    end
  end
end
