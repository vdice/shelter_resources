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
  ["City Team Ministries", "526 SE Grand Ave,Portland, OR 97214", "503-231-9334", "Cityteam is a non-denominational Christian non-profit serving the poor, the homeless, and the lost in local communities in the United States and around the world.  Since 1957, Cityteam has been serving people in extreme poverty and helping them transform their lives, their families and their communities where they live. Today with the help of volunteers and donors, Cityteam is impacting the lives of over 500,000 people each year just in the United States and helping hundreds of the thousands of lives in partnership with local leaders in 48 other countries around the world."],
  ["Portland Rescue Mission", "111 W Burnside St, Portland, OR 97209", "503-906-7690", "Founded in 1949 by John Van Diest Sr., the Mission opened its doors as the “John 3:16 Mission.”  Since then the Portland Rescue Mission has had a tireless commitment to breaking the cycle of homelessness. Today, we still offer emergency services of food and shelter at our original downtown location on 111 West Burnside. Additionally, men who come to us for addiction recovery go through a 12-month residential program at The Harbor. Afterwards, we have several options for them to successfully establish themselves in a new life.

"],

  ["VETS (Veterans Emergency Transitional Shelter)", "30 Sw 2nd Ave., Portland, OR 97204", "503-239-1259", "Short-term case management and transitional housing for veterans. Accepts men, women, and families for up to 9 months for veterans that qualify with TB card. Informational meeting every Wednesday at 9:00a.m.

Fees may apply for this Transitional Housing resource. Contact Vets (veterans Emergency Transitional Shelter) with the contact information we provided to get full details. Oftentimes you can apply for sliding scale fee payment or other options if you are low income. You will need to speak with them to see if you qualify."],

  ["Yolanda House For Women and Children", "1111 SW 10th Avenue", "503-535-3266", "The YWCA of Greater Portland strives to eliminate racism and discrimination in all its forms and provides growth, education and leadership opportunities for women and families. Yolanda House further strives to empower survivors to achieve personal safety, self-sufficiency, and a renewed sense of hope. We continually endeavor to help end domestic violence within our society through personal advocacy and education.

YWCA of Greater Portland created Yolanda House with the help of many community members and organizations to help those escaping domestic violence to survive. As part of the Domestic Violence community, we are saving lives and empowering women to reclaim their dignity and freedom.
"],

  ["Transition Projects TPI", "665 NW Hoyt St, Portland, OR 97209", "503-823-4930", "Transition Projects is a private non-profit agency governed by a volunteer board of directors. Our mission is to serve people's needs as they transition from homelessness to housing. With four locations in Portland, Oregon, Transition Projects serves homeless single adults throughout the metropolitan area. The agency is a catalyst for helping people end their homelessness.
The mission of Transition Projects is to serve people's basic needs as they transition from homelessness to housing."],
  ["Salvation Army Female Emergency Shelter (SAFES)", "30 SW 2nd Ave, Portland, OR 97204", "503-227-0810", "A shelter that provides temporary housing to women in need. The building is located on the corner of W Burnside Street and 2nd Avenue at the west end of the Burnside Bridge; the entrance is on 2nd Ave. SAFES is in the Old Town district of downtown Portland and provides services to people who identify and present as female."]
]

shelter_list.each() do |name, address, phone_number, description|
  new_shelter = Shelter.create({:name => name, :address => address, :phone_number => phone_number, :description => description})

  Resource.all().each() do |resource|
    resource_list.fetch(resource.name()).each() do |item_name|
      Item.create({:name => item_name, :quantity => rand(0...5), :resource_id => resource.id(), :shelter_id => new_shelter.id()})
    end
  end
end
