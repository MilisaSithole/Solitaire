public class Foundation extends CardHolder {
    public Foundation(float x, float y, float cardWidth, float cardHeight) {
        super(x, y);
        this.cardWidth = cardWidth;
        this.cardHeight = cardHeight;
    }

    @Override
    public void draw() {
        noStroke();
        if (cards.size() < 1) {
            fill(0, 0 , 0, 32);
            rectMode(CENTER);
            rect(pos.x, pos.y, cardWidth, cardHeight, 12);
            return;
        };

        cards.get(cards.size() - 1).draw();
        if (selected) {
            highlight();
        }
    }

    @Override
    public void addCard(Card card) {
        card.setPosition(new PVector(pos.x, pos.y));
        super.addCard(card);
    }
}