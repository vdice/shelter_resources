Resource.create({:name => 'bed'})
Resource.create({:name => 'meal'})

Shelter.create({:name => 'Transition Projects', :location => '665 Northwest Hoyt Street, Portland, OR 97209', :phone_number => "321-456-7890"})
Shelter.create({:name => 'Portland Rescue Mission', :location => '111 West Burnside Street, Portland, OR 97209', :phone_number => "321-456-7891"})
shelter_list = [
  ["City Team Ministries", "Portland, OR 97214", "503-231-9334"],
  ["Portland Rescue Mission", "Portland, OR 97209", "503-906-7690"],
  ["VETS (Veterans Emergency Transitional Shelter)", "Portland, OR 97204", "503-239-1259"],
  ["Transition Projects TPI", "Portland, OR 97209", "503-823-4930"],
  ["Salvation Army Female Emergency Shelter (SAFES)", "Portland, OR 97209", "503-227-0810"]
]

shelter_list.each do |name, location, phone_number|
  Shelter.create(name: name, location: location, phone_number: phone_number)
end
