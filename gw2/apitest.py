import gw2api as gw

x = gw.get_world_names(lang="us")
for i in x:
	if i['name'] == '''Yak's Bend''':
		srv = i

y = gw.get_map_names(lang='en')

for m in y:
	if m['name'] == 'Crystal Oasis':
		mapn = m

print(gw.get_events(map_id = mapn['id'], world_id = srv['id']))