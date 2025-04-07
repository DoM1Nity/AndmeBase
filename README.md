## Andmetüübid
1. **Arvulised** - int, decimal(50,2), kus 2 - numbri peale koma, bigint, smallint, real
2. **Teksti/sümbolid** - VARCHAR(255), CHAR(10), TEXT
Näited: telefoninumber, nimi, nimetus, isikukood, address
3. **kuupäeva** - DATE, TIME, date/time
4. **bloogilised** - bit, bool, boolean, true/false 

## Piirangud - ограничение
1. Primary key *- primaarne võti - первичный ключ
определяет уникальное значение для каждой строки / määrab unikaalne väärtus iga rea kohta
2. UNIQUE
3. NOT NULL - ei luba tühja väärtust
4. FOREIGN KEY - võõrvõti / väline võti - вторичный ключ
определяет набор значений из другой таблицы
5. CHECK - CHECK(naine, mees) - определяет набор значений и умножить на значение из скобок 
