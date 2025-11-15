UPDATE inventory SET quantity_kg = 0.5 WHERE material_id = 4;
-- t.ex. Jäst

SELECT
    m.name AS råvara,
    i.quantity_kg AS "Lager (kg)",
    i.reorder_level_kg AS "Beställ vid (kg)",
    CASE
        WHEN i.quantity_kg <= i.reorder_level_kg THEN 'Behöver beställas'
        ELSE 'OK'
    END AS status
FROM inventory i
    JOIN material m ON m.material_id = i.material_id
ORDER BY m.name;