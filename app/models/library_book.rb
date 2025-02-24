class LibraryBook < ApplicationRecord
    after_commit :broadcast_me

    def broadcast_me
        ActionCable.server.broadcast "LibraryBookStatusChannel:#{id}", {
            status: status.titleize,
            message: LibraryBooksController.render(
                partial: 'one_book',
                locals: {book: self}
            ).squish #이건 왜 하는거예요?
        }
    end
end
