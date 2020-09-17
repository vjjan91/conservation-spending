import re
import csv
import tqdm
import numpy as np
import pandas as pd


def string_found(string1, string2):
    if re.search(r"\b" + re.escape(string1) + r"\b", string2):
        return True
    return False


# Preprocessing to remove grants which are empty, operating support, etc.
data = pd.read_csv('./data/AllData - AllData.csv')
preproc_ph = pd.read_csv('./data/Preprocessing/Preprocessing_Phrases_v5.csv')
preproc_phrases = list(preproc_ph.Phrases)
data = data.drop([ele for ele in data.columns.to_list()
                  if ele not in ['Description']], axis=1)
data = data.dropna().reset_index(drop=True)

for phrase in preproc_phrases[:6]:
    data = data[~data.Description.str.contains(phrase)]

for phrase in preproc_phrases[6:]:
    data = data[data.Description.str.lower() != phrase]

data_sentences = data.Description.values.tolist()
data_sentences = [x.lower() for x in data_sentences]

# Bigrams/Keywords to be searched as substrings in description
keywords_df = pd.read_csv('./data/Keywords/keywords_alphabetized_v15.csv')
category_names = [x.strip() for x in list(keywords_df)]
keywords = []

for idx in range(len(category_names)):
    keywords.append(list(set(keywords_df[category_names[idx]].dropna())))

grant_categories = []
grant_keywords = []

pbar = tqdm.tqdm(total=len(data_sentences))
for grant in data_sentences:
    curr_cat = []
    curr_key = []
    for idx in range(len(category_names)):
        for keyword in keywords[idx]:
            if string_found(keyword, grant):
                curr_key.append(keyword.replace(' ', '_'))
                curr_cat.append(category_names[idx])
    grant_categories.append(curr_cat)
    grant_keywords.append(curr_key)
    pbar.update(1)
pbar.close()

# Store description, keywords and categories as csv
output_grants = []

pbar = tqdm.tqdm(total=len(data_sentences))
for idx in range(len(data_sentences)):
    temp = []
    temp.append(data_sentences[idx])
    temp.append("|".join(grant_keywords[idx]))
    temp.append("|".join(grant_categories[idx]))
    output_grants.append(temp)
    pbar.update(1)
pbar.close()

with open("./data/Output/output_grants_v15.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(['Description', 'Keywords', 'Categories'])
    writer.writerows(output_grants)
