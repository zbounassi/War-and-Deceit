-- Holds all of the card ranks 
Ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"}

-- Holds all of the card suits
Suits = {"Hearts", "Diamonds", "Spades", "Clubs"}

-- Holds the information of a single card
Card = {
    rank = "",
    suit = "",
    cardImg = "",
    cardVal = 0
}

Card.__index = Card

-- Constructor definition that will grant the information and image linking to a card
function Card:new(rank, suit, cardValue)
    local imagePath = "assets/cards/" .. rank .. "_of_" .. suit .. ".png"
    local card = {
        rank = rank, 
        suit = suit,
        -- image = love.graphics.newImage(imagePath)
        cardVal = cardValue
    }
    setmetatable(card, Card)
    return card
end

function Card:printCard()
    return (self.rank .. " of " .. self.suit)
end

-- Deck declaration (maybe need more in here)
Deck = {
    length = 0,
    crtCard = 0,
    cards = {}
}

Deck.__index = Deck

-- Constructor definition to make a Deck
function Deck:new()
    local newDeck = {
        length = 0,
        crtCard = 0,
        cards = {}
    }

    setmetatable(newDeck, Deck)
    return newDeck
end

-- Function to make a deck with all cards (not currently working)
function Deck:makeDeck()
    local deckCt = 1
    local crtRank = 2
    for i,v in ipairs(Ranks) do 
        for l, p in ipairs(Suits) do
            local card = Card:new(Ranks[i], Suits[l], crtRank)
            self.cards[deckCt] = card
            deckCt = deckCt + 1
        end
        crtRank = crtRank + 1
        self.length = deckCt - 1
        self.crtCard = 1
    end
    return self
end

-- Function to print all cards in the deck
function Deck:printDeck()
    for i,v in ipairs(self.cards) do
        print(self.cards[i]:printCard())
    end    
end


-- Function to shuffle the order of cards in a deck
function Deck:shuffleDeck()
    math.randomseed()
    local holderDeck = Deck:new()
    local cards = 52
    local rand = 0
    local i = 1

    while(cards > 0) do
        rand = math.random(cards)
        holderDeck.cards[i] = self.cards[rand]
        while(rand <= cards) do
            self.cards[rand] = self.cards[rand + 1]
            rand = rand + 1
        end
        i = i + 1
        cards = cards - 1
    end
    
    return holderDeck
end

-- Function to split a deck of cards into two halves
function Deck:splitDeck()
    local half1 = Deck:new()
    local half2 = Deck:new()
    half1.length = 0 
    half2.length = 0
    
    for i,v in ipairs(self.cards) do
        if(i % 2 == 0) then
            half2.length = half2.length + 1
            half2.cards[half2.length] = self.cards[i]
        else
            half1.length = half1.length + 1
            half1.cards[half1.length] = self.cards[i]
        end
    end
    return half1, half2
end

-- Function to deal the top card from a deck
function Deck:dealCard()
    local dealtCard = self.cards[1]
    local lastCard = self.length
    for i,v in ipairs(self.cards) do
        self.cards[i] = self.cards[i + 1]
    end
    self.length = self.length - 1
    self.cards[lastCard] = nil
    return dealtCard
end

--[[
    Block that will handle the creation of all decks to be used
    in the running of war. 
    Not currently operating as intended.
]]--
local startDeck = Deck:new()
startDeck:makeDeck()
startDeck = startDeck:shuffleDeck()

-- startDeck:printDeck()

P1Deck = Deck:new()
P2Deck = Deck:new()

P1Deck, P2Deck = startDeck:splitDeck()

P1WinPile = Deck:new()
P2WinPile = Deck:new()
PlayArea = Deck:new()



-- Function to compare the value of given cards
local function compareCards(p1Card, p2Card)
    if(p1Card.cardVal > p2Card.cardVal) then
        P1Win(p1Card, p2Card)
    elseif (p1Card.cardVal < p2Card.cardVal) then
        P2Win(p1Card, p2Card)
    else
        PlayWar()
    end
end

-- Function to handle the condition that p1 won the given play
function P1Win(p1Card, p2Card)
    print("\nPlayer 1 Wins! Their card " .. p1Card:printCard() .. " is greater than the " .. p2Card:printCard())
    P1WinPile.cards[P1WinPile.length] = p1Card
    P1WinPile.cards[P1WinPile.length + 1] = p2Card
    P1WinPile.length = P1WinPile.length + 2
end

-- Function to handle the condition that p2 won the given play
function P2Win(p1Card, p2Card)
    print("\nPlayer 2 Wins! Their card " .. p2Card:printCard() .. " is greater than the " .. p1Card:printCard())
    P2WinPile.cards[P2WinPile.length] = p1Card
    P2WinPile.cards[P2WinPile.length + 1] = p2Card
    P2WinPile.length = P2WinPile.length + 2
end

function PlayWar()
    print("\nThe cards have the same value, initiating a round of War!")
    for i = 1, 3 do
       PlayArea[PlayArea.length] = P1Deck:dealCard()
       PlayArea.length = PlayArea.length + 1
    end
    for i = 1, 3 do
        PlayArea[PlayArea.length] = P2Deck:dealCard()
       PlayArea.length = PlayArea.length + 1
    end
    compareCards(P1Deck:dealCard(), P2Deck:dealCard())
end

--[[

-- Creates a Deck named testDeck
local testDeck = Deck:new()

-- local testCard = Card:new("Ace", "Diamonds")

-- testCard:printCard() 

testDeck:makeDeck()

testDeck:printDeck()

 
while(testDeck.length > 0) do
    local printCrd = testDeck:dealCard()
    printCrd:printCard()
end



print('checking the nil status of the deck after that')


-- print("\nTesting the shuffle deck function\n")

local shuff, testDeck = testDeck:shuffleDeck()
-- shuff:printDeck()

-- The split function is working as intended

local split1 = Deck:new()
local split2 = Deck:new()

split1, split2 = shuff:splitDeck()

-- split1:printDeck()

-- print("\n this is the point between 1 and 2 \n ")

-- split2:printDeck()

]]--

--[[
local passes = 20
while(passes > 0) do
    local p1Card = split1:dealCard()
    local p2Card = split2:dealCard()
    compareCards(p1Card, p2Card)
    passes = passes - 1
end
]]--

--[[

    Block to handle the execution of the war game. 
    Not currently operating as intended.

P1Deck:printDeck()

print("\n\nDeck two\n\n")

P2Deck:printDeck()

]]--

while(P1Deck.length > 0 and P2Deck.length > 0) do
    local p1Card = P1Deck:dealCard()
    local p2Card = P2Deck:dealCard()
    print("\nWe are now comparing " .. p1Card:printCard() .. " and " .. p2Card:printCard())
    compareCards(p1Card, p2Card)
end


-- Check the status of the win piles
P1WinPile:printDeck()

print("\nOnto P2's pile\n")

P2WinPile:printDeck()

