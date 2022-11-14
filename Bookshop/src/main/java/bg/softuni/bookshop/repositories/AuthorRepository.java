package bg.softuni.bookshop.repositories;

import bg.softuni.bookshop.entities.Author;
import bg.softuni.bookshop.entities.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.xml.crypto.dsig.spec.XSLTTransformParameterSpec;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {
    Optional<List<Author>> findDistinctByBooksReleaseDateBefore(LocalDate date);

    @Query("Select a from Author a order by a.books.size")
    Optional<List<Author>> findAllDistinctOrderByBooks();

    Optional<Author> findAuthorById(Long id);
    Optional<List<Author>> findAuthorByFirstNameEndingWith(String end);


}
