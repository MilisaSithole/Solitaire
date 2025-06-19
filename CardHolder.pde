import java.util.ArrayList;
import java.util.Collections;

public abstract class CardHolder {
    PVector pos;
    ArrayList<Card> cards = new ArrayList();
    boolean selected = false;

    float cardWidth, cardHeight, fontSize, hiddenHeight;

    public CardHolder(float x, float y) {
        pos = new PVector(x, y);
    }

    public abstract void draw();

    public PVector getPos() {
        return pos;
    }

    public void addCard(Card card) {
        if (cards.size() == 0) {
            cardWidth = card.getWidth();
            cardHeight = card.getHeight();
            fontSize = cardWidth * 0.3;
            hiddenHeight = cardHeight * 0.1;
        }

        cards.add(card);
    }

    public Card popCard() {
        if (cards.size() > 0) {
            return cards.remove(cards.size() - 1);
        }
        return null;
    }

    public int getSize() {
        return cards.size();
    }

    public void toggleSelected() {
        selected = !selected;
    }

    public void unselect() {
        selected = false;
    }

    public void initCards(ArrayList<Card> cards) {
        for (Card card: cards) {
            addCard(card);
        }
    }

    public boolean isClicked(float x, float y) {
        if (x > pos.x - cardWidth/2 && x < pos.x + cardWidth/2 &&
            y > pos.y - cardHeight/2 && y < pos.y + cardHeight/2) {
            return true;
        }

        return false;
    }

    public Card handleClick() {
        if (cards.size() == 0) return null;

        toggleSelected();
        return selected ? cards.get(cards.size() - 1) : null;
    }

    protected void highlight() {
        stroke(250);
        noFill();
        strokeWeight(2);
        rectMode(CENTER);

        float offset = cardWidth * 0.075;
        rect(pos.x, pos.y, cardWidth + offset, cardHeight + offset, 12);
    }
}