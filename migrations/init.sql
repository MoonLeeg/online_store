-- Создание таблицы пользователей
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY, -- Уникальный идентификатор пользователя, автоматически увеличивается
    username VARCHAR(50) UNIQUE NOT NULL, -- Имя пользователя, должно быть уникальным и не может быть пустым
    email VARCHAR(100) UNIQUE NOT NULL, -- Электронная почта пользователя, должна быть уникальной и не может быть пустой
    password VARCHAR(100) NOT NULL, -- Пароль пользователя, не может быть пустым
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата и время создания записи, по умолчанию текущие время
);

-- Создание таблицы продуктов
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY, -- Уникальный идентификатор продукта, автоматически увеличивается
    name VARCHAR(100) NOT NULL, -- Название продукта, не может быть пустым
    description TEXT, -- Описание продукта, текстовое поле
    price DECIMAL(10,2) NOT NULL, -- Цена продукта с точностью до двух знаков после запятой, не может быть пустой
    stock INT NOT NULL, -- Количество товара на складе, не может быть пустым
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата и время добавления продукта, по умолчанию текущие время
);

-- Создание таблицы корзин
CREATE TABLE IF NOT EXISTS carts (
    id SERIAL PRIMARY KEY, -- Уникальный идентификатор корзины, автоматически увеличивается
    user_id INT REFERENCES users(id), -- Ссылка на идентификатор пользователя из таблицы users, указывает владельца корзины
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата и время создания корзины, по умолчанию текущие время
);

-- Создание таблицы элементов корзины
CREATE TABLE IF NOT EXISTS cart_items (
    id SERIAL PRIMARY KEY, -- Уникальный идентификатор элемента корзины, автоматически увеличивается
    cart_id INT REFERENCES carts(id), -- Ссылка на идентификатор корзины из таблицы carts, указывает, к какой корзине относится этот элемент
    product_id INT REFERENCES products(id), -- Ссылка на идентификатор продукта из таблицы products, указывает, какой продукт добавлен в корзину
    quantity INT NOT NULL, -- Количество данного продукта в корзине, не может быть пустым
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата и время добавления продукта в корзину, по умолчанию текущие время
);
