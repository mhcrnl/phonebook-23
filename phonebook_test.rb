require 'test/unit'
require_relative 'phonebook'

class PhonebookTest < Test::Unit::TestCase

  def setup
    File.open('phonebook_test.json', 'w') do |file|
      file.write({}.to_json)
    end
    @phonebook = Phonebook.new
  end

  def teardown
    File.delete('phonebook_test.json')
  end

  def test_phonebook_file_creation
    @phonebook.create_phonebook('new_book.json')
    assert File.exist?('new_book.json')

    assert_raise(RuntimeError) { @phonebook.create_phonebook('new_book.json') }

    File.delete('new_book.json')
  end

  def test_create_contact
    assert @phonebook.add_contact('phonebook_test.json', 'Foo Bar', '1234567890')

    assert_raise(RuntimeError) { @phonebook.add_contact('phonebook_test.json', 'Foo Bar', '1234567890') }
  end

  def test_delete_contact
    @phonebook.add_contact('phonebook_test.json', 'Foo Bar', '1234567890')

    assert @phonebook.remove_contact('phonebook_test.json', 'Foo Bar')
  end

  def test_contact_lookup
    @phonebook.add_contact('phonebook_test.json', 'Foo Bar', '1234567890')
    @contact = @phonebook.lookup('phonebook_test.json', 'Foo Bar')
    assert_equal @contact['Foo Bar'], '1234567890'
  end

  def test_edit_contact
    @phonebook.add_contact('phonebook_test.json', 'Foo Bar', '1234567890')
    assert @phonebook.edit_contact('phonebook_test.json', 'Foo Bar', '0987654321')

    @edited_contact = @phonebook.lookup('phonebook_test.json', 'Foo Bar')
    assert_equal @edited_contact['Foo Bar'], '0987654321'
  end

  def test_reverse_lookup

    # I will implement it maybe someday before apocalypse or before second apocalypse

  end
end
