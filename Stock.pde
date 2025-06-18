public class Stock extends CardHolder {
    public Stock(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        if (cards.size() > 0) {
            fill(250, 50, 100);
            rectMode(CENTER);
            rect(pos.x, pos.y, cardWidth, cardHeight, 12);

            textAlign(CENTER, CENTER);
            textSize(fontSize);
            fill(51);
            text(cards.size(), pos.x, pos.y);
        } else {
            stroke(250, 50, 100);
            strokeWeight(cardWidth * 0.1);
            noFill();
            rectMode(CENTER);
            rect(pos.x, pos.y, cardWidth*0.6, cardWidth*0.6, 12);
        }
    }

    @Override
    public Card handleClick() {
        if (cards.size() > 0) {
            return drawCard();
        }
        return null;
    }

    private Card drawCard() {
        if (cards.size() > 0) {
            return cards.remove(cards.size() - 1);
        }

        return null;
    }
}