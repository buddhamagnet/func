export function selectBook(book) {
  return {
    type: 'BOOK_SELECTED',
    book
  };
}