DROP TABLE IF EXISTS supplier;

-- Tabell: Leverantörer
CREATE TABLE supplier (
    supplier_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT,
    contact_person TEXT,
    phone TEXT,
    email TEXT,
    UNIQUE (name, phone)
);

DROP TABLE IF EXISTS material;

-- Tabell: Råvaror
CREATE TABLE material (
    material_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    internal_article_number TEXT UNIQUE
);

DROP TABLE IF EXISTS supplier_material;

-- Tabell: Koppling mellan leverantör och råvara (pris och artikelnummer)
CREATE TABLE supplier_material (
    supplier_material_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    supplier_article_number TEXT NOT NULL,
    price_per_kg REAL NOT NULL CHECK (price_per_kg >= 0),
    UNIQUE (
        supplier_id,
        supplier_article_number
    ),
    UNIQUE (supplier_id, material_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON DELETE RESTRICT,
    FOREIGN KEY (material_id) REFERENCES material (material_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS product;

-- Tabell: Produkter
CREATE TABLE product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

DROP TABLE IF EXISTS recipe;

-- Tabell: Recept (ett recept per produkt)
CREATE TABLE recipe (
    recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL UNIQUE,
    instructions TEXT,
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS recipe_ingredient;

-- Tabell: Ingredienser i ett recept
CREATE TABLE recipe_ingredient (
    recipe_ingredient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    quantity_kg REAL NOT NULL CHECK (quantity_kg > 0),
    UNIQUE (recipe_id, material_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (material_id) REFERENCES material (material_id) ON DELETE RESTRICT
);

DROP TABLE IF EXISTS inventory;

-- Tabell: Lager
CREATE TABLE inventory (
    material_id INTEGER PRIMARY KEY,
    quantity_kg REAL NOT NULL DEFAULT 0 CHECK (quantity_kg >= 0),
    reorder_level_kg REAL NOT NULL DEFAULT 0 CHECK (reorder_level_kg >= 0),
    FOREIGN KEY (material_id) REFERENCES material (material_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS purchase;

-- Tabell Inköp
CREATE TABLE purchase (
    purchase_id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    purchase_date TEXT NOT NULL DEFAULT(DATE('now')),
    total_amount REAL NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) ON DELETE RESTRICT
);

DROP TABLE IF EXISTS purchase_line;

-- Tabell Inköpsrader
CREATE TABLE purchase_line (
    purchase_line_id INTEGER PRIMARY KEY AUTOINCREMENT,
    purchase_id INTEGER NOT NULL,
    supplier_material_id INTEGER NOT NULL,
    quantity_kg REAL NOT NULL CHECK (quantity_kg > 0),
    unit_price REAL NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_material_id) REFERENCES supplier_material (supplier_material_id) ON DELETE RESTRICT
);