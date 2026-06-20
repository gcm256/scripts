import requests
import pandas as pd

YEAR = "2023"

IMR_INDICATOR = "SP.DYN.IMRT.IN"
POP_INDICATOR = "SP.POP.TOTL"

def fetch_indicator(indicator):
    url = f"https://api.worldbank.org/v2/country/all/indicator/{indicator}"
    
    params = {
        "format": "json",
        "date": YEAR,
        "per_page": 20000
    }

    r = requests.get(url, params=params)
    data = r.json()[1]

    rows = []
    for item in data:
        if item["value"] is None:
            continue

        rows.append({
            "iso3": item["countryiso3code"],
            "country": item["country"]["value"],
            indicator: float(item["value"])
        })

    return pd.DataFrame(rows)


# Fetch data
imr = fetch_indicator(IMR_INDICATOR)
pop = fetch_indicator(POP_INDICATOR)

# Merge on ISO3
df = pd.merge(imr, pop, on="iso3", how="inner")

# Rename columns
df = df.rename(columns={
    "SP.DYN.IMRT.IN": "IMR",
    "SP.POP.TOTL": "Population"
})

# Clean invalid rows
df = df.dropna(subset=["IMR", "Population"])

# Apply population filter
df = df[df["Population"] >= 5_000_000]

# IMPORTANT: strict global sort (this fixes all earlier issues)
df = df.sort_values(by="IMR", ascending=True).reset_index(drop=True)

# Assign rank AFTER sorting
df.insert(0, "Rank", df.index + 1)

# Keep clean output columns
df = df[["Rank", "country", "IMR", "Population"]]

# Save CSV
df.to_csv("world_bank_imr_ranked_pop_5m_2023.csv", index=False)

print(df.head(30))
print("\nSaved: world_bank_imr_ranked_pop_5m_2023.csv")
