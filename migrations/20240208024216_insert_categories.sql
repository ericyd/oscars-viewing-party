/*
Best Picture
---

AMERICAN FICTION
Ben LeClair, Nikos Karamigios, Cord Jefferson and Jermaine Johnson, Producers

ANATOMY OF A FALL
Marie-Ange Luciani and David Thion, Producers

BARBIE
David Heyman, Margot Robbie, Tom Ackerley and Robbie Brenner, Producers

THE HOLDOVERS
Mark Johnson, Producer

KILLERS OF THE FLOWER MOON
Dan Friedkin, Bradley Thomas, Martin Scorsese and Daniel Lupi, Producers

MAESTRO
Bradley Cooper, Steven Spielberg, Fred Berner, Amy Durning and Kristie Macosko Krieger, Producers

OPPENHEIMER
Emma Thomas, Charles Roven and Christopher Nolan, Producers

PAST LIVES
David Hinojosa, Christine Vachon and Pamela Koffler, Producers

POOR THINGS
Ed Guiney, Andrew Lowe, Yorgos Lanthimos and Emma Stone, Producers

THE ZONE OF INTEREST
James Wilson, Producer
*/

with best_picture as (
  insert into categories (category, meta_category) values ('Best Picture', 'Overall')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Ben LeClair, Nikos Karamigios, Cord Jefferson and Jermaine Johnson, Producers', 'American Fiction', (select id from best_picture), 2024),
  ('Marie-Ange Luciani and David Thion, Producers', 'Anatomy Of A Fall', (select id from best_picture), 2024),
  ('David Heyman, Margot Robbie, Tom Ackerley and Robbie Brenner, Producers', 'Barbie', (select id from best_picture), 2024),
  ('Mark Johnson, Producer', 'The Holdovers', (select id from best_picture), 2024),
  ('Dan Friedkin, Bradley Thomas, Martin Scorsese and Daniel Lupi, Producers', 'Killers Of The Flower Moon', (select id from best_picture), 2024),
  ('Bradley Cooper, Steven Spielberg, Fred Berner, Amy Durning and Kristie Macosko Krieger, Producers', 'Maestro', (select id from best_picture), 2024),
  ('Emma Thomas, Charles Roven and Christopher Nolan, Producers', 'Oppenheimer', (select id from best_picture), 2024),
  ('David Hinojosa, Christine Vachon and Pamela Koffler, Producers', 'Past Lives', (select id from best_picture), 2024),
  ('Ed Guiney, Andrew Lowe, Yorgos Lanthimos and Emma Stone, Producers', 'Poor Things', (select id from best_picture), 2024),
  ('James Wilson, Producer', 'The Zone Of Interest', (select id from best_picture), 2024)
;

/*
Actor in a Leading Role
---

Bradley Cooper in MAESTRO

Colman Domingo in RUSTIN

Paul Giamatti in THE HOLDOVERS

Cillian Murphy in OPPENHEIMER

Jeffrey Wright in AMERICAN FICTION

*/

with best_actor as (
  insert into categories (category, meta_category) values ('Actor in a Leading Role', 'Acting')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Bradley Cooper', 'Maestro', (select id from best_actor), 2024),
  ('Colman Domingo', 'Rustin', (select id from best_actor), 2024),
  ('Paul Giamatti', 'The Holdovers', (select id from best_actor), 2024),
  ('Cillian Murphy', 'Oppenheimer', (select id from best_actor), 2024),
  ('Jeffrey Wright', 'American Fiction', (select id from best_actor), 2024)
;

/*

Actor in a Supporting Role
---
('Sterling K. Brown', 'American Fiction', (select id from supporting_actor), 2024),
('Robert De Niro', 'Killers Of The Flower Moon', (select id from supporting_actor), 2024),
('Robert Downey Jr.', 'Oppenheimer', (select id from supporting_actor), 2024),
('Ryan Gosling', 'Barbie', (select id from supporting_actor), 2024),
('Mark Ruffalo', 'Poor Things', (select id from supporting_actor), 2024)

*/

with supporting_actor as (
  insert into categories (category, meta_category) values ('Actor in a Supporting Role', 'Acting')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Sterling K. Brown', 'American Fiction', (select id from supporting_actor), 2024),
  ('Robert De Niro', 'Killers Of The Flower Moon', (select id from supporting_actor), 2024),
  ('Robert Downey Jr.', 'Oppenheimer', (select id from supporting_actor), 2024),
  ('Ryan Gosling', 'Barbie', (select id from supporting_actor), 2024),
  ('Mark Ruffalo', 'Poor Things', (select id from supporting_actor), 2024)
;

/*
Actress in a Leading Role
---
Annette Bening in NYAD
Lily Gladstone in KILLERS OF THE FLOWER MOON
Sandra Hüller in ANATOMY OF A FALL
Carey Mulligan in MAESTRO
Emma Stone in POOR THINGS
*/

with best_actress as (
  insert into categories (category, meta_category) values ('Actress in a Leading Role', 'Acting')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Annette Bening', 'Nyad', (select id from best_actress), 2024),
  ('Lily Gladstone', 'Killers Of The Flower Moon', (select id from best_actress), 2024),
  ('Sandra Hüller', 'Anatomy Of A Fall', (select id from best_actress), 2024),
  ('Carey Mulligan', 'Maestro', (select id from best_actress), 2024),
  ('Emma Stone', 'Poor Things', (select id from best_actress), 2024)
;

/*
Actress in a Supporting Role
---
Emily Blunt in OPPENHEIMER
Danielle Brooks in THE COLOR PURPLE
America Ferrera in BARBIE
Jodie Foster in NYAD
Da'Vine Joy Randolph in THE HOLDOVERS

*/


with supporting_actress as (
  insert into categories (category, meta_category) values ('Actress in a Supporting Role', 'Acting')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Emily Blunt', 'Oppenheimer', (select id from supporting_actress), 2024),
  ('Danielle Brooks', 'The Color Purple', (select id from supporting_actress), 2024),
  ('America Ferrera', 'Barbie', (select id from supporting_actress), 2024),
  ('Jodie Foster', 'Nyad', (select id from supporting_actress), 2024),
  ('Da''Vine Joy Randolph', 'The Holdovers', (select id from supporting_actress), 2024)
;

/*
Animated Feature Film
---

THE BOY AND THE HERON
Hayao Miyazaki and Toshio Suzuki

ELEMENTAL
Peter Sohn and Denise Ream

NIMONA
Nick Bruno, Troy Quane, Karen Ryan and Julie Zackary

ROBOT DREAMS
Pablo Berger, Ibon Cormenzana, Ignasi Estapé and Sandra Tapia Díaz

SPIDER-MAN: ACROSS THE SPIDER-VERSE
Kemp Powers, Justin K. Thompson, Phil Lord, Christopher Miller and Amy Pascal
*/

with animated_feature as (
  insert into categories (category, meta_category) values ('Animated Feature Film', 'Features')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Hayao Miyazaki and Toshio Suzuki', 'The Boy And The Heron', (select id from animated_feature), 2024),
  ('Peter Sohn and Denise Ream', 'Elemental', (select id from animated_feature), 2024),
  ('Nick Bruno, Troy Quane, Karen Ryan and Julie Zackary', 'Nimona', (select id from animated_feature), 2024),
  ('Pablo Berger, Ibon Cormenzana, Ignasi Estapé and Sandra Tapia Díaz', 'Robot Dreams', (select id from animated_feature), 2024),
  ('Kemp Powers, Justin K. Thompson, Phil Lord, Christopher Miller and Amy Pascal', 'Spider-Man: Across The Spider-Verse', (select id from animated_feature), 2024)
;

/*
Cinematography
---

EL CONDE
Edward Lachman

KILLERS OF THE FLOWER MOON
Rodrigo Prieto

MAESTRO
Matthew Libatique

OPPENHEIMER
Hoyte van Hoytema

POOR THINGS
Robbie Ryan
*/


with cinematography as (
  insert into categories (category, meta_category) values ('Cinematography', 'Overall')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Edward Lachman', 'El Conde', (select id from cinematography), 2024),
  ('Rodrigo Prieto', 'Killers Of The Flower Moon', (select id from cinematography), 2024),
  ('Matthew Libatique', 'Maestro', (select id from cinematography), 2024),
  ('Hoyte van Hoytema', 'Oppenheimer', (select id from cinematography), 2024),
  ('Robbie Ryan', 'Poor Things', (select id from cinematography), 2024)
;

/*
Costume Design
---

BARBIE
Jacqueline Durran

KILLERS OF THE FLOWER MOON
Jacqueline West

NAPOLEON
Janty Yates and Dave Crossman

OPPENHEIMER
Ellen Mirojnick

POOR THINGS
Holly Waddington
*/

with costume_design as (
  insert into categories (category, meta_category) values ('Costume Design', 'Visuals')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Jacqueline Durran', 'Barbie', (select id from costume_design), 2024),
  ('Jacqueline West', 'Killers Of The Flower Moon', (select id from costume_design), 2024),
  ('Janty Yates and Dave Crossman', 'Napoleon', (select id from costume_design), 2024),
  ('Ellen Mirojnick', 'Oppenheimer', (select id from costume_design), 2024),
  ('Holly Waddington', 'Poor Things', (select id from costume_design), 2024)
;

/*

Directing
---

^ANATOMY OF A FALL
Justine Triet

^KILLERS OF THE FLOWER MOON
Martin Scorsese

^OPPENHEIMER
Christopher Nolan

^POOR THINGS
Yorgos Lanthimos

^THE ZONE OF INTEREST
Jonathan Glazer
*/

with directing as (
  insert into categories (category, meta_category) values ('Directing', 'Overall')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Justine Triet', 'Anatomy Of A Fall', (select id from directing), 2024),
  ('Martin Scorsese', 'Killers Of The Flower Moon', (select id from directing), 2024),
  ('Christopher Nolan', 'Oppenheimer', (select id from directing), 2024),
  ('Yorgos Lanthimos', 'Poor Things', (select id from directing), 2024),
  ('Jonathan Glazer', 'The Zone Of Interest', (select id from directing), 2024)
;


/*
Documentary Feature Film
---

BOBI WINE: THE PEOPLE'S PRESIDENT
Moses Bwayo, Christopher Sharp and John Battsek

THE ETERNAL MEMORY
Nominees to be determined

FOUR DAUGHTERS
Kaouther Ben Hania and Nadim Cheikhrouha

TO KILL A TIGER
Nisha Pahuja, Cornelia Principe and David Oppenheim

20 DAYS IN MARIUPOL
Mstyslav Chernov, Michelle Mizner and Raney Aronson-Rath
*/

with documentary_feature as (
  insert into categories (category, meta_category) values ('Documentary Feature', 'Features')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Moses Bwayo, Christopher Sharp and John Battsek', 'Bobi Wine: The People''s President', (select id from documentary_feature), 2024),
  ('Nominees to be determined', 'The Eternal Memory', (select id from documentary_feature), 2024),
  ('Kaouther Ben Hania and Nadim Cheikhrouha', 'Four Daughters', (select id from documentary_feature), 2024),
  ('Nisha Pahuja, Cornelia Principe and David Oppenheim', 'To Kill A Tiger', (select id from documentary_feature), 2024),
  ('Mstyslav Chernov, Michelle Mizner and Raney Aronson-Rath', '20 Days In Mariupol', (select id from documentary_feature), 2024)
;

/*

Documentary Short Film
---

THE ABCS OF BOOK BANNING
Sheila Nevins and Trish Adlesic

THE BARBER OF LITTLE ROCK
John Hoffman and Christine Turner

ISLAND IN BETWEEN
S. Leo Chiang and Jean Tsien

THE LAST REPAIR SHOP
Ben Proudfoot and Kris Bowers

NǎI NAI & WàI Pó
Sean Wang and Sam Davis
*/

with documentary_short as (
  insert into categories (category, meta_category) values ('Documentary Short', 'Shorts')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Sheila Nevins and Trish Adlesic', 'The Abcs Of Book Banning', (select id from documentary_short), 2024),
  ('John Hoffman and Christine Turner', 'The Barber Of Little Rock', (select id from documentary_short), 2024),
  ('S. Leo Chiang and Jean Tsien', 'Island In Between', (select id from documentary_short), 2024),
  ('Ben Proudfoot and Kris Bowers', 'The Last Repair Shop', (select id from documentary_short), 2024),
  ('Sean Wang and Sam Davis', 'Nǎi Nai & Wài Pó', (select id from documentary_short), 2024)
;

/*
Film Editing
---

ANATOMY OF A FALL
Laurent Sénéchal

THE HOLDOVERS
Kevin Tent

KILLERS OF THE FLOWER MOON
Thelma Schoonmaker

OPPENHEIMER
Jennifer Lame

POOR THINGS
Yorgos Mavropsaridis

*/
with editing as (
  insert into categories (category, meta_category) values ('Film Editing', 'Overall')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Laurent Sénéchal', 'Anatomy Of A Fall', (select id from editing), 2024),
  ('Kevin Tent', 'The Holdovers', (select id from editing), 2024),
  ('Thelma Schoonmaker', 'Killers Of The Flower Moon', (select id from editing), 2024),
  ('Jennifer Lame', 'Oppenheimer', (select id from editing), 2024),
  ('Yorgos Mavropsaridis', 'Poor Things', (select id from editing), 2024)
;

/*

International Feature Film
---

IO CAPITANO
Italy

PERFECT DAYS
Japan

SOCIETY OF THE SNOW
Spain

THE TEACHERS' LOUNGE
Germany

THE ZONE OF INTEREST
United Kingdom
*/
with intl_feature as (
  insert into categories (category, meta_category) values ('International Feature Film', 'Features')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Italy', 'Io Capitano', (select id from intl_feature), 2024),
  ('Japan', 'Perfect Days', (select id from intl_feature), 2024),
  ('Spain', 'Society Of The Snow', (select id from intl_feature), 2024),
  ('Germany', 'The Teachers'' Lounge', (select id from intl_feature), 2024),
  ('United Kingdom', 'The Zone Of Interest', (select id from intl_feature), 2024)
;

/*
Makeup and Hairstyling
---

GOLDA
Karen Hartley Thomas, Suzi Battersby and Ashra Kelly-Blue

MAESTRO
Kazu Hiro, Kay Georgiou and Lori McCoy-Bell

OPPENHEIMER
Luisa Abel

POOR THINGS
Nadia Stacey, Mark Coulier and Josh Weston

SOCIETY OF THE SNOW
Ana López-Puigcerver, David Martí and Montse Ribé
*/

with makeup_hair as (
  insert into categories (category, meta_category) values ('Makeup and Hairstyling', 'Visuals')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Karen Hartley Thomas, Suzi Battersby and Ashra Kelly-Blue', 'Golda', (select id from makeup_hair), 2024),
  ('Kazu Hiro, Kay Georgiou and Lori McCoy-Bell', 'Maestro', (select id from makeup_hair), 2024),
  ('Luisa Abel', 'Oppenheimer', (select id from makeup_hair), 2024),
  ('Nadia Stacey, Mark Coulier and Josh Weston', 'Poor Things', (select id from makeup_hair), 2024),
  ('Ana López-Puigcerver, David Martí and Montse Ribé', 'Society Of The Snow', (select id from makeup_hair), 2024)
;

/*
Music (Original Score)
---

AMERICAN FICTION
Laura Karpman

INDIANA JONES AND THE DIAL OF DESTINY
John Williams

KILLERS OF THE FLOWER MOON
Robbie Robertson

OPPENHEIMER
Ludwig Göransson

POOR THINGS
Jerskin Fendrix
*/


with original_score as (
  insert into categories (category, meta_category) values ('Original Score', 'Sound')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Laura Karpman', 'American Fiction', (select id from original_score), 2024),
  ('John Williams', 'Indiana Jones And The Dial Of Destiny', (select id from original_score), 2024),
  ('Robbie Robertson', 'Killers Of The Flower Moon', (select id from original_score), 2024),
  ('Ludwig Göransson', 'Oppenheimer', (select id from original_score), 2024),
  ('Jerskin Fendrix', 'Poor Things', (select id from original_score), 2024)
;

/*
Music (Original Song)
---

"The Fire Inside" from FLAMIN' HOT
Music and Lyric by Diane Warren

"I'm Just Ken" from BARBIE
Music and Lyric by Mark Ronson and Andrew Wyatt

"It Never Went Away" from AMERICAN SYMPHONY
Music and Lyric by Jon Batiste and Dan Wilson

"Wahzhazhe (A Song For My People)" from KILLERS OF THE FLOWER MOON
Music and Lyric by Scott George

"What Was I Made For?" from BARBIE
Music and Lyric by Billie Eilish and Finneas O'Connell

*/

with original_song as (
  insert into categories (category, meta_category) values ('Original Song', 'Sound')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Diane Warren', '"The Fire Inside" from Flamin'' Hot', (select id from original_song), 2024),
  ('Mark Ronson and Andrew Wyatt', '"I''m Just Ken" from Barbie', (select id from original_song), 2024),
  ('Jon Batiste and Dan Wilson', '"It Never Went Away" from American Symphony', (select id from original_song), 2024),
  ('Scott George', '"Wahzhazhe (A Song For My People)" from Killers Of The Flower Moon', (select id from original_song), 2024),
  ('Billie Eilish and Finneas O''Connell', '"What Was I Made For?" from Barbie', (select id from original_song), 2024)
;

/*
Production Design
---

BARBIE
Production Design: Sarah Greenwood; Set Decoration: Katie Spencer

KILLERS OF THE FLOWER MOON
Production Design: Jack Fisk; Set Decoration: Adam Willis

NAPOLEON
Production Design: Arthur Max; Set Decoration: Elli Griff

OPPENHEIMER
Production Design: Ruth De Jong; Set Decoration: Claire Kaufman

POOR THINGS
Production Design: James Price and Shona Heath; Set Decoration: Zsuzsa Mihalek
*/

with production_design as (
  insert into categories (category, meta_category) values ('Production Design', 'Visuals')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Production Design: Sarah Greenwood; Set Decoration: Katie Spencer', 'Barbie', (select id from production_design), 2024),
  ('Production Design: Jack Fisk; Set Decoration: Adam Willis', 'Killers Of The Flower Moon', (select id from production_design), 2024),
  ('Production Design: Arthur Max; Set Decoration: Elli Griff', 'Napoleon', (select id from production_design), 2024),
  ('Production Design: Ruth De Jong; Set Decoration: Claire Kaufman', 'Oppenheimer', (select id from production_design), 2024),
  ('Production Design: James Price and Shona Heath; Set Decoration: Zsuzsa Mihalek', 'Poor Things', (select id from production_design), 2024)
;

/*

Short Film (Animated)
---

LETTER TO A PIG
Tal Kantor and Amit R. Gicelter

NINETY-FIVE SENSES
Jerusha Hess and Jared Hess

OUR UNIFORM
Yegane Moghaddam

PACHYDERME
Stéphanie Clément and Marc Rius

WAR IS OVER! INSPIRED BY THE MUSIC OF JOHN & YOKO
Dave Mullins and Brad Booker
*/

with animated_short as (
  insert into categories (category, meta_category) values ('Animated Short Film', 'Shorts')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Tal Kantor and Amit R. Gicelter', 'Letter To A Pig', (select id from animated_short), 2024),
  ('Jerusha Hess and Jared Hess', 'Ninety-Five Senses', (select id from animated_short), 2024),
  ('Yegane Moghaddam', 'Our Uniform', (select id from animated_short), 2024),
  ('Stéphanie Clément and Marc Rius', 'Pachyderme', (select id from animated_short), 2024),
  ('Dave Mullins and Brad Booker', 'War Is Over! Inspired By The Music Of John & Yoko', (select id from animated_short), 2024)
;

/*

Short Film (Live Action)
---

THE AFTER
Misan Harriman and Nicky Bentham

INVINCIBLE
Vincent René-Lortie and Samuel Caron

KNIGHT OF FORTUNE
Lasse Lyskjær Noer and Christian Norlyk

RED, WHITE AND BLUE
Nazrin Choudhury and Sara McFarlane

THE WONDERFUL STORY OF HENRY SUGAR
Wes Anderson and Steven Rales
*/
with live_short as (
  insert into categories (category, meta_category) values ('Live Action Short Film', 'Shorts')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Misan Harriman and Nicky Bentham', 'The After', (select id from live_short), 2024),
  ('Vincent René-Lortie and Samuel Caron', 'Invincible', (select id from live_short), 2024),
  ('Lasse Lyskjær Noer and Christian Norlyk', 'Knight Of Fortune', (select id from live_short), 2024),
  ('Nazrin Choudhury and Sara McFarlane', 'Red, White And Blue', (select id from live_short), 2024),
  ('Wes Anderson and Steven Rales', 'The Wonderful Story Of Henry Sugar', (select id from live_short), 2024)
;

/*
Sound
---

THE CREATOR
Ian Voigt, Erik Aadahl, Ethan Van der Ryn, Tom Ozanich and Dean Zupancic

MAESTRO
Steven A. Morrow, Richard King, Jason Ruder, Tom Ozanich and Dean Zupancic

MISSION: IMPOSSIBLE - DEAD RECKONING PART ONE
Chris Munro, James H. Mather, Chris Burdon and Mark Taylor

OPPENHEIMER
Willie Burton, Richard King, Gary A. Rizzo and Kevin O'Connell

THE ZONE OF INTEREST
Tarn Willers and Johnnie Burn

*/

with sound as (
  insert into categories (category, meta_category) values ('Best Sound', 'Sound')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Ian Voigt, Erik Aadahl, Ethan Van der Ryn, Tom Ozanich and Dean Zupancic', 'The Creator', (select id from sound), 2024),
  ('Steven A. Morrow, Richard King, Jason Ruder, Tom Ozanich and Dean Zupancic', 'Maestro', (select id from sound), 2024),
  ('Chris Munro, James H. Mather, Chris Burdon and Mark Taylor', 'Mission: Impossible - Dead Reckoning Part One', (select id from sound), 2024),
  ('Willie Burton, Richard King, Gary A. Rizzo and Kevin O''Connell', 'Oppenheimer', (select id from sound), 2024),
  ('Tarn Willers and Johnnie Burn', 'The Zone Of Interest', (select id from sound), 2024)
;


/*
Visual Effects
---

THE CREATOR
Jay Cooper, Ian Comley, Andrew Roberts and Neil Corbould

GODZILLA MINUS ONE
Takashi Yamazaki, Kiyoko Shibuya, Masaki Takahashi and Tatsuji Nojima

GUARDIANS OF THE GALAXY VOL. 3
Stephane Ceretti, Alexis Wajsbrot, Guy Williams and Theo Bialek

MISSION: IMPOSSIBLE - DEAD RECKONING PART ONE
Alex Wuttke, Simone Coco, Jeff Sutherland and Neil Corbould

NAPOLEON
Charley Henley, Luc-Ewen Martin-Fenouillet, Simone Coco and Neil Corbould

*/
with vfx as (
  insert into categories (category, meta_category) values ('Visual Effects', 'Visuals')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Jay Cooper, Ian Comley, Andrew Roberts and Neil Corbould', 'The Creator', (select id from vfx), 2024),
  ('Takashi Yamazaki, Kiyoko Shibuya, Masaki Takahashi and Tatsuji Nojima', 'Godzilla Minus One', (select id from vfx), 2024),
  ('Stephane Ceretti, Alexis Wajsbrot, Guy Williams and Theo Bialek', 'Guardians Of The Galaxy Vol. 3', (select id from vfx), 2024),
  ('Alex Wuttke, Simone Coco, Jeff Sutherland and Neil Corbould', 'Mission: Impossible - Dead Reckoning Part One', (select id from vfx), 2024),
  ('Charley Henley, Luc-Ewen Martin-Fenouillet, Simone Coco and Neil Corbould', 'Napoleon', (select id from vfx), 2024)
;

/*

Writing (Adapted Screenplay)
---

AMERICAN FICTION
Written for the screen by Cord Jefferson

BARBIE
Written by Greta Gerwig & Noah Baumbach

OPPENHEIMER
Written for the screen by Christopher Nolan

POOR THINGS
Screenplay by Tony McNamara

THE ZONE OF INTEREST
Written by Jonathan Glazer

*/

with adapted_screenplay as (
  insert into categories (category, meta_category) values ('Adapted Screenplay', 'Writing')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Written for the screen by Cord Jefferson', 'American Fiction', (select id from adapted_screenplay), 2024),
  ('Written by Greta Gerwig & Noah Baumbach', 'Barbie', (select id from adapted_screenplay), 2024),
  ('Written for the screen by Christopher Nolan', 'Oppenheimer', (select id from adapted_screenplay), 2024),
  ('Screenplay by Tony McNamara', 'Poor Things', (select id from adapted_screenplay), 2024),
  ('Written by Jonathan Glazer', 'The Zone Of Interest', (select id from adapted_screenplay), 2024)
;

/*

Writing (Original Screenplay)
---

ANATOMY OF A FALL
Screenplay - Justine Triet and Arthur Harari

THE HOLDOVERS
Written by David Hemingson

MAESTRO
Written by Bradley Cooper & Josh Singer

MAY DECEMBER
Screenplay by Samy Burch; Story by Samy Burch & Alex Mechanik

PAST LIVES
Written by Celine Song
*/

with original_screenplay as (
  insert into categories (category, meta_category) values ('Original Screenplay', 'Writing')
  returning id
)

insert into nominees (nominee, artwork, category_id, year) values
  ('Screenplay - Justine Triet and Arthur Harari', 'Anatomy Of A Fall', (select id from original_screenplay), 2024),
  ('Written by David Hemingson', 'The Holdovers', (select id from original_screenplay), 2024),
  ('Written by Bradley Cooper & Josh Singer', 'Maestro', (select id from original_screenplay), 2024),
  ('Screenplay by Samy Burch; Story by Samy Burch & Alex Mechanik', 'May December', (select id from original_screenplay), 2024),
  ('Written by Celine Song', 'Past Lives', (select id from original_screenplay), 2024)
;
