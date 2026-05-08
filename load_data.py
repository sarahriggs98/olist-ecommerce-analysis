import pandas as pd
from sqlalchemy import create_engine
import os

# Connect to PostgreSQL
engine = create_engine('postgresql://localhost/olist_ecommerce')

# Folder where your CSV files live
data_folder = os.path.dirname(os.path.abspath(__file__))

# Map each CSV file to a table name
datasets = {
    'olist_orders_dataset.csv': 'orders',
    'olist_customers_dataset.csv': 'customers',
    'olist_order_items_dataset.csv': 'order_items',
    'olist_products_dataset.csv': 'products',
    'olist_sellers_dataset.csv': 'sellers',
    'olist_order_payments_dataset.csv': 'order_payments',
    'olist_order_reviews_dataset.csv': 'order_reviews',
    'olist_geolocation_dataset.csv': 'geolocation',
}

# Load each CSV into PostgreSQL
for filename, table_name in datasets.items():
    filepath = os.path.join(data_folder, filename)
    if os.path.exists(filepath):
        print(f'Loading {filename} into {table_name}...')
        df = pd.read_csv(filepath)
        df.to_sql(table_name, engine, if_exists='replace', index=False)
        print(f'Done! {len(df)} rows loaded.')
    else:
        print(f'Warning: {filename} not found, skipping.')

print('All done!')