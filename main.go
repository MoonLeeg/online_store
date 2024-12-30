package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

var db *sql.DB

func main() {
	// Загрузка переменных окружения
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Ошибка загрузки .env файла: %v", err)
	}

	// Инициализация подключения к базе данных
	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		os.Getenv("DB_HOST"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_NAME"),
	)

	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Не удалось подключиться к базе данных: %v", err)
	}

	// Проверка подключения
	err = db.Ping()
	if err != nil {
		log.Fatalf("Не удалось проверить подключение к базе данных: %v", err)
	}

	fmt.Println("Успешно подключено к базе данных!")

	// Настройка маршрутов
	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/products", productsHandler)

	port := os.Getenv("PORT")
	fmt.Printf("Сервер запущен на порту %s\n", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Добро пожаловать в онлайн-магазин!")
}

func productsHandler(w http.ResponseWriter, r *http.Request) {
	products, err := GetAllProducts()
	if err != nil {
		http.Error(w, "Ошибка при получении продуктов", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(products)
}
