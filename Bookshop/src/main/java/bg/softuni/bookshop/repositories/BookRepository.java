package bg.softuni.bookshop.repositories;

import bg.softuni.bookshop.entities.Book;
import bg.softuni.bookshop.enums.AgeRestriction;
import bg.softuni.bookshop.enums.EditionType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    Optional<List<Book>> findAllByReleaseDateAfter(LocalDate date);
    Optional<List<Book>> findAllByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc(String firstName, String lastName);

    Optional<List<Book>> findAllByAgeRestriction(AgeRestriction restriction);
    Optional<List<Book>> findAllByEditionTypeAndCopiesLessThan(EditionType editionType, int copies);
    Optional<List<Book>> findAllByPriceLessThanOrPriceGreaterThan(BigDecimal lowerPrice, BigDecimal higherPrice);
    Optional<List<Book>> findAllByReleaseDateNot(LocalDate date);
    Optional<List<Book>> findAllByReleaseDateBefore(LocalDate date);
    Optional<List<Book>> findAllByTitleContainsIgnoreCase(String searchedString);
    Optional<List<Book>> findAllByAuthorLastNameStartingWith(String searchedString);

    @Query("select count(b) from Book b where length(b.title) > :size")
    Optional<Integer> findAllByTitleSizeGreaterThan(int size);

    Optional<Book> findFirstByTitle(String title);

}
