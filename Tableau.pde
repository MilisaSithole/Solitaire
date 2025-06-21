public class Tableau extends CardHolder {
    float hiddenHeight, hiddenOffset, cardOffset, totalHeight;
    ArrayList<Card> hiddenCards = new ArrayList<>();

    public Tableau(float x, float y) {
        super(x, y);
    }

    @Override
    public void draw() {
        drawHidden();

        drawVisible();
        // cards.get(cards.size()-1).draw(pos.x, pos.y + hiddenOffset);
    }

    @Override
    public void initCards(ArrayList<Card> cards) {
        super.initCards(cards);
        hiddenHeight = cardHeight * 0.05;

        for (int i = 0; i < cards.size() - 1; i++) {
            hiddenCards.add(super.cards.remove(0));
        }
    }

    @Override
    public boolean isClicked(float x, float y) {
        if (x > pos.x - cardWidth/2 && x < pos.x + cardWidth/2 &&
            y > pos.y - cardHeight/2 && y < pos.y - cardHeight/2 + totalHeight) {
            return true;
        }

        return false;
    }

    @Override
    public Card popCard() {
        println();

        if (cards.size() > 1) {
            return cards.remove(cards.size() - 1);
        }
        else if (cards.size() == 1 && hiddenCards.size() > 0) {
            Card lastCard = cards.remove(0);
            addCard(hiddenCards.remove(hiddenCards.size() - 1));
            return lastCard;
        }
        else if (cards.size() == 1 && hiddenCards.size() == 0) {
            return cards.remove(0);
        }
        return null;
    }

    @Override
    protected void highlight() {
        stroke(250);
        noFill();
        strokeWeight(2);
        rectMode(CENTER);

        PVector cardPos = cards.get(cards.size() - 1).getPosition();
        float offset = cardWidth * 0.075;
        rect(cardPos.x, cardPos.y, cardWidth + offset, cardHeight + offset, 12);
    }

    private void drawHidden() {
        hiddenOffset = hiddenCards.size() < 1 ? 0 : hiddenHeight * (hiddenCards.size() + 1);
        if (hiddenCards.size() < 1) return;

        noStroke();
        fill(250, 50, 100);
        rectMode(CENTER);
        float y = pos.y - cardHeight/2 + hiddenHeight*hiddenCards.size()/2;
        rect(pos.x, y, cardWidth, hiddenHeight*hiddenCards.size(), 12);
    }

    private void drawVisible() {
        if (cards.size() < 1) return;

        cardOffset = cardHeight * 0.2;
        for (int i = 0; i < cards.size(); i++) {
            if (i < cards.size() - 1) {
                cards.get(i).draw(pos.x, pos.y + hiddenOffset + (i * cardOffset), cardOffset);
            } else {
                cards.get(i).draw(pos.x, pos.y + hiddenOffset + (i * cardOffset));
            }
        }

        totalHeight = hiddenOffset + (cards.size() - 1) * cardOffset + cardHeight;

        if (selected && cards.size() == 1) {
            highlight();
        }
    }

    public void printSummary() {
        println("Tableau at " + pos.x + ", " + pos.y);
        println("Visible cards: " + cards.size());
        println("Hidden cards: " + hiddenCards.size());
        println();
    }
}