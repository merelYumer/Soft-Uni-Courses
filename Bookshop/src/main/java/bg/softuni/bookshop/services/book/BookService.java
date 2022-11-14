package bg.softuni.bookshop.services.book;

import bg.softuni.bookshop.entities.Book;
import bg.softuni.bookshop.enums.AgeRestriction;
import bg.softuni.bookshop.enums.EditionType;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface BookService {
    void seedBooks(List<Book> books);
    List<Book> findAllByReleaseDateAfter(LocalDate localDate);
    List<Book> findAllByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc(String firstName, String lastName);

    List<Book> findAllByAgeRestriction(AgeRestriction restriction);
    List<Book> findAllByEditionTypeAndCopiesLessThan(EditionType editionType, int copies);
    List<Book> findAllByPriceLessThanOrPriceGreaterThan(BigDecimal lowerPrice, BigDecimal higherPrice);

    List<Book> findAllByReleaseDateNot(LocalDate date);
    List<Book> findAllByReleaseDateBefore(LocalDate date);
    List<Book> findAllByTitleContainsIgnoreCase(String searchedString);
    List<Book> findAllByAuthorLastNameStartingWith(String searchedString);
    Integer findAllByTitleIsGreaterThan(Integer size);
    Book findFirstByTitle(String title);
}
