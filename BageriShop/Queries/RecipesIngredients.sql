SELECT p.name AS produkt, m.name AS råvara, ri.quantity_kg
FROM
    product p
    JOIN recipe r ON r.product_id = p.product_id
    JOIN recipe_ingredient ri ON ri.recipe_id = r.recipe_id
    JOIN material m ON m.material_id = ri.material_id
ORDER BY p.name;