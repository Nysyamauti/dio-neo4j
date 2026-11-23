// EDUCATIONAL EXAMPLE (DO NOT RUN - Commented to prevent duplicate nodes/rels)
// Initial test using CREATE (always creates new entities even if they exist):
// CREATE (:User {name: 'f1'})-[:LISTENED]->(faded:Song {name: 'Faded'})<-[:COMPOSED {date: date('2015-12-03')}]-(:Composer {name: 'Alan Walker'}),
//        (faded)-[:BELONGS_TO]->(:Genre {name: 'Electronic'})

// ACTIVE SEED SCRIPT (run from here - Idempotent script using MERGE)

// 1. Create Genres
MERGE (gElec:Genre {name: 'Electronic'})
MERGE (gHipHop:Genre {name: 'Hip-Hop'})
MERGE (gPop:Genre {name: 'Pop'})

// 2. Create Composers
MERGE (cAlan:Composer {name: 'Alan Walker'})
MERGE (cMarsh:Composer {name: 'Marshmello'})
MERGE (cEminem:Composer {name: 'Eminem'})
MERGE (cWeeknd:Composer {name: 'The Weeknd'})

// 3. Create Songs and link to Composers & Genres
MERGE (sFaded:Song {name: 'Faded'})
MERGE (sFaded)-[:COMPOSED_BY {date: date('2015-12-03')}]->(cAlan)
MERGE (sFaded)-[:BELONGS_TO]->(gElec)

MERGE (sAlone:Song {name: 'Alone'})
MERGE (sAlone)-[:COMPOSED_BY {date: date('2016-12-02')}]->(cAlan)
MERGE (sAlone)-[:BELONGS_TO]->(gElec)

MERGE (sHappier:Song {name: 'Happier'})
MERGE (sHappier)-[:COMPOSED_BY {date: date('2018-08-17')}]->(cMarsh)
MERGE (sHappier)-[:BELONGS_TO]->(gElec)

MERGE (sVenom:Song {name: 'Venom'})
MERGE (sVenom)-[:COMPOSED_BY {date: date('2020-02-27')}]->(cEminem)
MERGE (sVenom)-[:BELONGS_TO]->(gHipHop)

MERGE (sLose:Song {name: 'Lose Yourself'})
MERGE (sLose)-[:COMPOSED_BY {date: date('2002-10-28')}]->(cEminem)
MERGE (sLose)-[:BELONGS_TO]->(gHipHop)

MERGE (sBlinding:Song {name: 'Blinding Lights'})
MERGE (sBlinding)-[:COMPOSED_BY {date: date('2019-11-29')}]->(cWeeknd)
MERGE (sBlinding)-[:BELONGS_TO]->(gPop)

// 4. Create Users
MERGE (u1:User {name: 'f1'})
MERGE (u2:User {name: 'f2'})
MERGE (u3:User {name: 'f3'})

// 5. Create Interactions (LISTENED, LIKED, FOLLOWS)
// User f1 likes Electronic & Hip-Hop
MERGE (u1)-[:LISTENED {plays: 15}]->(sFaded)
MERGE (u1)-[:LISTENED {plays: 8}]->(sVenom)
MERGE (u1)-[:LIKED]->(sFaded)
MERGE (u1)-[:FOLLOWS]->(cAlan)

// User f2 has similar taste to f1 (bridges to Alone, Happier & Lose Yourself)
MERGE (u2)-[:LISTENED {plays: 20}]->(sFaded)
MERGE (u2)-[:LISTENED {plays: 12}]->(sAlone)
MERGE (u2)-[:LISTENED {plays: 9}]->(sHappier)
MERGE (u2)-[:LIKED]->(sAlone)
MERGE (u2)-[:LIKED]->(sLose)
MERGE (u2)-[:FOLLOWS]->(cMarsh)

// User f3 listens to Pop
MERGE (u3)-[:LISTENED {plays: 30}]->(sBlinding)
MERGE (u3)-[:LIKED]->(sBlinding)
MERGE (u3)-[:FOLLOWS]->(cWeeknd);
