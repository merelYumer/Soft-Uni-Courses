package bg.softuni.bookshop.services.book;

import bg.softuni.bookshop.entities.Book;
import bg.softuni.bookshop.enums.AgeRestriction;
import bg.softuni.bookshop.enums.EditionType;
import bg.softuni.bookshop.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class BookServiceImpl implements BookService{
    private final BookRepository bookRepository;

    @Autowired
    public BookServiceImpl(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }
    @Override
    public void seedBooks(List<Book> books) {
        this.bookRepository.saveAll(books);
    }

    @Override
    public List<Book> findAllByReleaseDateAfter(LocalDate date) {
        return this.bookRepository.findAllByReleaseDateAfter(date).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc(String firstName, String lastName) {
        return this.bookRepository.findAllByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc(firstName, lastName).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByAgeRestriction(AgeRestriction restriction) {
        return this.bookRepository.findAllByAgeRestriction(restriction).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByEditionTypeAndCopiesLessThan(EditionType editionType, int copies) {
        return this.bookRepository.findAllByEditionTypeAndCopiesLessThan(editionType, copies).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByPriceLessThanOrPriceGreaterThan(BigDecimal lowerPrice, BigDecimal higherPrice) {
        return this.bookRepository.findAllByPriceLessThanOrPriceGreaterThan(lowerPrice, higherPrice).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByReleaseDateNot(LocalDate date) {
        return this.bookRepository.findAllByReleaseDateNot(date).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByReleaseDateBefore(LocalDate date) {
        return this.bookRepository.findAllByReleaseDateBefore(date).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByTitleContainsIgnoreCase(String searchedString) {
        return this.bookRepository.findAllByTitleContainsIgnoreCase(searchedString).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public List<Book> findAllByAuthorLastNameStartingWith(String searchedString) {
        return this.bookRepository.findAllByAuthorLastNameStartingWith(searchedString).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public Integer findAllByTitleIsGreaterThan(Integer size) {
        return this.bookRepository.findAllByTitleSizeGreaterThan(size).orElseThrow(NoSuchElementException::new);
    }

    @Override
    public Book findFirstByTitle(String title) {
        return this.bookRepository.findFirstByTitle(title).orElseThrow(NoSuchElementException::new);
    }


}
