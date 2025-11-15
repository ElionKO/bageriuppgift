-- Leverantörer
INSERT INTO
    supplier (
        name,
        address,
        contact_person,
        phone,
        email
    )
VALUES (
        'Bageri Leverantören AB',
        'Storgatan 1, 11122 Stad',
        'Pernilla Åkesson',
        '040-828334756',
        'pernilla@gmail.com'
    ),
    (
        'Kvarn & Co',
        'Kvarnvägen 5, 22233 Stad',
        'Hans Åkesson',
        '040-3215678435',
        'Hans@gmail.com'
    );

-- Råvaror
INSERT INTO
    material (
        name,
        description,
        internal_article_number
    )
VALUES (
        'Vetemjöl',
        'Siktat vetemjöl',
        'MJOL-001'
    ),
    (
        'Socker',
        'Rörsocker',
        'SUKR-010'
    ),
    (
        'Smör',
        'Osaltat smör',
        'SMOR-005'
    ),
    (
        'Jäst',
        'Torrjäst',
        'JAST-002'
    );

-- Leverantörens artiklar
INSERT INTO
    supplier_material (
        supplier_id,
        material_id,
        supplier_article_number,
        price_per_kg
    )
VALUES (1, 1, 'VET-100', 6.50),
    (1, 2, 'SUK-100', 4.20),
    (2, 1, 'VET-Q', 6.10),
    (2, 3, 'SMOR-1KG', 40.00),
    (1, 4, 'JAST-50G', 120.00);

INSERT INTO
    product (name, description)
VALUES (
        'Kanelbulle',
        'Klassisk kanelbulle'
    ),
    (
        'Bondbröd',
        'Rustikt lantbröd'
    );

-- Recept
INSERT INTO
    recipe (product_id, instructions)
VALUES (1, 'Blanda, jäsa, baka'),
    (
        2,
        'Blanda, lång jäsning, baka'
    );

-- Recept-ingredienser
INSERT INTO
    recipe_ingredient (
        recipe_id,
        material_id,
        quantity_kg
    )
VALUES (1, 1, 0.5),
    (1, 2, 0.05),
    (1, 3, 0.08),
    (2, 1, 1.2);

-- Lager
INSERT INTO
    inventory (
        material_id,
        quantity_kg,
        reorder_level_kg
    )
VALUES (1, 10, 2),
    (2, 10, 2),
    (3, 5, 1),
    (4, 1, 0.5);

-- Exempelinköp
INSERT INTO
    purchase (supplier_id, purchase_date)
VALUES (1, DATE('now'));

INSERT INTO
    purchase_line (
        purchase_id,
        supplier_material_id,
        quantity_kg,
        unit_price
    )
VALUES (1, 1, 25, 6.50);