class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  const Question(this.questionText, this.options, this.correctAnswer);
}

const List<Question> quizData = [
  Question(
    '1. Sungai terpanjang di dunia adalah?',
    ['Sungai Amazon', 'Sungai Nil', 'Sungai Yangtze', 'Sungai Mississippi'],
    'Sungai Nil',
  ),
  Question(
    '2. Planet manakah dalam tata surya kita yang paling dekat dengan Matahari?',
    ['Mars', 'Venus', 'Merkurius', 'Bumi'],
    'Merkurius',
  ),
  Question(
    '3. Karya terkenal "Mona Lisa" dilukis oleh siapa?',
    ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Claude Monet'],
    'Leonardo da Vinci',
  ),
  Question(
    '4. Bahan kimia apa yang memberi warna hijau pada tumbuhan?',
    ['Karoten', 'Melanin', 'Klorofil', 'Hemoglobin'],
    'Klorofil',
  ),
  Question(
    '5. Negara mana yang memiliki populasi terbanyak di dunia (perkiraan saat ini)?',
    ['Tiongkok', 'Amerika Serikat', 'India', 'Indonesia'],
    'India', // Saat ini, India telah menyalip Tiongkok
  ),
  Question(
    '6. Berapa jumlah benua yang ada di Bumi?',
    ['Lima', 'Enam', 'Tujuh', 'Delapan'],
    'Tujuh',
  ),
  Question(
    '7. Kota mana yang dikenal sebagai "Kota Abadi"?',
    ['Athena', 'Roma', 'Yerusalem', 'Istanbul'],
    'Roma',
  ),
  Question(
    '8. Satuan mata uang negara Jepang adalah?',
    ['Won', 'Yuan', 'Yen', 'Ringgit'],
    'Yen',
  ),
  Question(
    '9. Siapakah yang menulis drama terkenal "Romeo dan Juliet"?',
    ['Jane Austen', 'Charles Dickens', 'William Shakespeare', 'Mark Twain'],
    'William Shakespeare',
  ),
  Question(
    '10. Gunung tertinggi di dunia adalah?',
    ['Gunung Fuji', 'Gunung Everest', 'Gunung Kilimanjaro', 'Gunung McKinley'],
    'Gunung Everest',
  ),
];