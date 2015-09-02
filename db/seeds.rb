shelter_list = [
  ["City Team Ministries", "Portland, OR 97214", "503-231-9334"],
  ["Portland Rescue Mission", "Portland, OR 97209", "503-906-7690"],
  ["VETS (Veterans Emergency Transitional Shelter)", "Portland, OR 97204", "503-239-1259"],
  ["Transition Projects TPI", "Portland, OR 97209", "503-823-4930"],
  ["Salvation Army Female Emergency Shelter (SAFES)", "Portland, OR 97209", "503-227-0810"]
]

shelter_list.each do |name, address, phone_number|
  Shelter.create(name: name, address: address, phone_number: phone_number)
end

resource_list = ["hygine products", "linens", "clothing","books","toys","food"]

resource_list. each do |name|
  Resource.create(name: name)
end
