package main

import (
	"log"
)

type Product struct {
	ID          int
	Name        string
	Description string
	Price       float64
	Stock       int
}

func GetAllProducts() ([]Product, error) {
	rows, err := db.Query("SELECT id, name, description, price, stock FROM products")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var products []Product

	for rows.Next() {
		var p Product
		err := rows.Scan(&p.ID, &p.Name, &p.Description, &p.Price, &p.Stock)
		if err != nil {
			log.Println("Ошибка сканирования строки:", err)
			continue
		}
		products = append(products, p)
	}

	return products, nil
}
