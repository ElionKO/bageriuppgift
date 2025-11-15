SELECT s.name AS leverantör, m.name AS råvara, sm.price_per_kg
FROM
    supplier s
    JOIN supplier_material sm ON s.supplier_id = sm.supplier_id
    JOIN material m ON m.material_id = sm.material_id
ORDER BY s.name;