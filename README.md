# System Zarządzania Biblioteką

Projekt akademicki zrealizowany w ramach kursu "Bazy Danych". Celem projektu było zaprojektowanie i zaimplementowanie w pełni funkcjonalnego schematu relacyjnej bazy danych symulującego działanie systemu informatycznego biblioteki.

Repozytorium zawiera plik `.sql` ze strukturą tabel, zdefiniowanymi relacjami oraz przykładowymi danymi, co pozwala na szybkie wdrożenie i testowanie modelu.

## Spis Treści
- [Cel Projektu](#cel-projektu)
- [Opis Systemu i Założenia Biznesowe](#opis-systemu-i-założenia-biznesowe)
- [Schemat Bazy Danych](#schemat-bazy-danych)
- [Instalacja i Wdrożenie](#instalacja-i-wdrożenie)
- [Przykładowe Zapytania SQL](#przykładowe-zapytania-sql)

## Cel Projektu

Głównym celem było stworzenie logicznego i spójnego modelu danych, który odzwierciedla kluczowe procesy zachodzące w bibliotece. Projekt kładzie nacisk na normalizację danych, zapewnienie ich integralności poprzez użycie kluczy głównych i obcych, a także na umożliwienie efektywnego odpytywania bazy w celu uzyskania istotnych informacji.

## Opis Systemu i Założenia Biznesowe

Zaprojektowany system `biblioteka_koncowe` ma na celu obsługę następujących obszarów funkcjonalnych:

*   **Ewidencja Zasobów:** Zarządzanie katalogiem książek, informacjami o autorach i latach wydania.
*   **Kategoryzacja Księgozbioru:** Elastyczne przypisywanie książek do jednej lub wielu kategorii (np. "Powieść", "Horror") za pomocą relacji wiele-do-wielu.
*   **Zarządzanie Użytkownikami:** Rejestracja danych czytelników (klientów) oraz personelu biblioteki (pracowników).
*   **Obsługa Procesu Wypożyczeń:** Śledzenie transakcji wypożyczeń, w tym rejestrowanie dat, przypisanie czytelnika, książki oraz obsługującego pracownika.
*   **System Kar:** Ewidencja kar finansowych naliczanych za nieterminowe zwroty książek, powiązanych bezpośrednio z rekordem wypożyczenia.

## Schemat Bazy Danych

Model bazy danych składa się z 8 tabel. Poniżej przedstawiono ich przeznaczenie oraz kluczowe relacje:

1.  `autorzy`: Przechowuje dane autorów.
2.  `kategorie`: Słownik dostępnych kategorii (gatunków) książek.
3.  `ksiażki`: Główna tabela z informacjami o książkach, połączona relacją *jeden-do-wielu* z tabelą `autorzy`.
4.  `klienci`: Rejestr czytelników biblioteki.
5.  `pracownicy`: Rejestr pracowników.
6.  `ksiazki_kategorie`: Tabela asocjacyjna implementująca relację *wiele-do-wielu* między książkami a kategoriami.
7.  `wypozyczenia`: Tabela transakcyjna, która łączy dane z tabel `klienci`, `ksiażki` i `pracownicy`, rejestrując proces wypożyczenia.
8.  `kary`: Rejestr nałożonych kar, połączony relacją *jeden-do-wielu* z tabelą `wypozyczenia`.

Integralność referencyjna jest zapewniona przez zastosowanie więzów kluczy obcych (FOREIGN KEY).

## Instalacja i Wdrożenie

Aby odtworzyć strukturę bazy danych i zaimportować przykładowe dane, należy postępować według poniższych kroków.

**Wymagania:** serwer bazy danych MySQL lub MariaDB (np. z pakietu XAMPP).

### Metoda 1: Import przez wiersz poleceń (CLI)

1.  Utwórz pustą bazę danych:
    ```sql
    CREATE DATABASE biblioteka_koncowe CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    ```
2.  Zaimportuj strukturę i dane z pliku `libraryDB.sql` za pomocą polecenia:
    ```bash
    mysql -u [nazwa_uzytkownika] -p biblioteka_koncowe < libraryDB.sql
    ```

### Metoda 2: Import przez phpMyAdmin

1.  W interfejsie phpMyAdmin utwórz nową bazę danych o nazwie `biblioteka_koncowe`, wybierając system kodowania znaków `utf8mb4_general_ci`.
2.  Przejdź do nowo utworzonej bazy.
3.  Wybierz zakładkę "Import".
4.  Kliknij "Wybierz plik" i wskaż plik `libraryDB.sql` z tego repozytorium.
5.  Zatwierdź operację, klikając przycisk "Wykonaj".

## Przykładowe Zapytania SQL

**1. Sprawdzenie, kto aktualnie przetrzymuje książkę (brak daty zwrotu):**
```sql
SELECT k.imie, k.nazwisko, ks.tytul, w.data_wypozyczenia 
FROM wypozyczenia w
JOIN klienci k ON w.klient_id = k.klient_id
JOIN ksiażki ks ON w.ksiazka_id = ks.ksiazka_id
WHERE w.data_zwrotu IS NULL;
```
**2. Wyświetlenie książek wraz z ich autorami i połączonymi kategoriami:**
```sql
SELECT ks.tytul, a.imie, a.nazwisko, GROUP_CONCAT(kat.nazwa SEPARATOR ', ') as gatunki
FROM ksiażki ks
JOIN autorzy a ON ks.autor_id = a.autor_id
JOIN ksiazki_kategorie kk ON ks.ksiazka_id = kk.ksiazka_id
JOIN kategorie kat ON kk.kategoria_id = kat.kategoria_id
GROUP BY ks.ksiazka_id;
```
**3. Raport zadłużenia klientów**
```sql
SELECT 
    k.imie, 
    k.nazwisko, 
    SUM(ka.kwota) AS laczna_kwota_kar
FROM klienci k
JOIN wypozyczenia w ON k.klient_id = w.klient_id
JOIN kary ka ON w.wypozyczenie_id = ka.wypozyczenie_id
GROUP BY k.klient_id
HAVING laczna_kwota_kar > 0;
```
**4. Ranking popularności autorów (według liczby wypożyczeń)**
```sql
SELECT 
    a.imie, 
    a.nazwisko, 
    COUNT(w.wypozyczenie_id) AS liczba_wypozyczen
FROM autorzy a
JOIN ksiażki ks ON a.autor_id = ks.autor_id
JOIN wypozyczenia w ON ks.ksiazka_id = w.ksiazka_id
GROUP BY a.autor_id
ORDER BY liczba_wypozyczen DESC;
```
**5. Średni czas wypożyczenia książki**
```sql
SELECT 
    AVG(DATEDIFF(data_zwrotu, data_wypozyczenia)) AS sredni_czas_wypozyczenia_dni
FROM wypozyczenia
WHERE data_zwrotu IS NOT NULL;
```
**6. Wydajność pracowników**
```sql
SELECT 
    p.imie, 
    p.nazwisko, 
    p.stanowisko, 
    COUNT(w.wypozyczenie_id) AS obsłużone_wypozyczenia
FROM pracownicy p
LEFT JOIN wypozyczenia w ON p.pracownik_id = w.pracownik_id
GROUP BY p.pracownik_id;
```


