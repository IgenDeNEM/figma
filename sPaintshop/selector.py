import os

root_dir = r"C:\Users\Administrator\Desktop\Sight - Main\[1] Sight - Main Server\server\mods\deathmatch\resources\sPaintshop\paintjobs"

paintjob_files = []

for dirpath, dirnames, filenames in os.walk(root_dir):
    for filename in filenames:
        if "MASK" in filename:
            rel_path = os.path.relpath(os.path.join(dirpath, filename), start=root_dir)
            full_path = f"paintjobs/{rel_path.replace(os.sep, '/')}"
            paintjob_files.append(full_path)

print('paintjobFiles = {')
for file in paintjob_files:
    print(f'\t\"{file}\",')
print('}')