-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 29 avr. 2026 à 17:21
-- Version du serveur : 8.0.31
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `chaabi_music_v4`
--

-- --------------------------------------------------------

--
-- Structure de la table `artistes`
--

DROP TABLE IF EXISTS `artistes`;
CREATE TABLE IF NOT EXISTS `artistes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `image` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie_id` int NOT NULL,
  `views` int NOT NULL DEFAULT '0',
  `likes` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_artists_name` (`nom`),
  KEY `idx_artists_category` (`categorie_id`),
  KEY `idx_artistes_views` (`views`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `artistes`
--

INSERT INTO `artistes` (`id`, `nom`, `bio`, `user_id`, `image`, `categorie_id`, `views`, `likes`, `created_at`) VALUES
(1, 'Abdelhamid ababsa', 'Né : le 15 décembre 1918 à Barika (Batna).\r\n(Auteur compositeur interprète et poète)\r\nUne famille de musiciens pendant près de 40 ans, le père a été l’une des grandes figures de la musique algérienne Ababsa Abdelhamid Orphelin de mère à dix mois.\r\nGrandit à Biskra\r\nAbdelhamid Ababsa apprit la musique en allant tapoter du piano dans une taverne du côté de l\'Amirauté qui appartenait à un Italien. \r\nMessaoud el Habib, un pianiste qui fut durant de longues années le musicien attitré de Cheikh el Afrit, aux côtés de M\'hamed el Kourd, l\'aida beaucoup. Par la suite, il apprit le luth, l\'orgue (el manfakh).\r\nMais, le secret de la musique, il l\'a pénétré en autodidacte et ses premiers pas dans la chanson nationaliste, il les fit en mettant en musique une qacida de son père.\r\nC\'est lui aussi qui composa la musique du chant patriotique Fidaou el Djazair de son ami Moufdi Zakaria. Né dans le terreau du nationalisme et de la poésie populaire, il atteint la plénitude dans l\'interprétation des chants, celle des qaçaids, en 1936, à Tlemcen, sur la place El Kheddam, quand il chanta devant douze mille personnes, le nachid Fidaou el Djaiair. Pour cela, il sera proscrit de la ville.\r\nDepuis, il se mit à composer des qacidates et des chansons.\r\nEn 1942, il enregistre chez Pacific Talet aâlya, en 1944 Ya rahala, mais c\'est Hyua qui connut le plus grand succès, chanson qu\'il interpréta pour la première fois, après Slimane Mégari, en 1938, à la radio d\'Alger, et qu\'il n\'enregistre sur disque qu\'en 1947. Depuis cette date, cette chanson qu\'interprétera avec brio également El Bar Amar, demeure la plus demandée et la plus appréciée par les mélomanes. Après cet exploit, encouragé par le public, Abdelhamid (Abdelmadjid à l\'état civil) monte sa propre troupe Djawalat Ababsa (19371976) et composa lui même les poèmes de ses chansons.\r\nEn 1945, il dénonce le massacre du 8 mai et en 1946, lors d\'un meeting, il chanta la même chanson à Paris et se retrouva en prison, pour deux ans, en compagnie de Cheikh El Hasnaoni. Durant la guerre de libération, il organise en France des galas privés pour la communauté émigrée et à la veille de l\'indépendance, il se consacra aux anachid et chansons patriotiques.', 4, 'img_artistes/abdelhamid ababsa.jpg', 1, 87, 153, '2023-12-03 05:40:36'),
(2, 'Abdelkader chaou', 'Brillant Interprète de chaâbi.. Né le 10 novembre 1941 à Bab Jdid à la Casbah d\'Alger, il fit ses débuts à Radio Crochet, une émission de Djillali Haddad, encourage par ses amis et ses proches, il s\'inscrivit au conservatoire d\'Alger, dirige à l\'époque par Hadj M\'hamed El Anka. Après ce passage, Chaou enregistre sa première chanson Ya dhou A yani, à Radio Alger dirigée par Mustapha Kechkoul. Grâce à l\'école Mahboub Bati dont il a été un élève émérite, il a fait une percée fulgurante dans les années 70. En 1966, il fit son premier enregistrement à la Radio et deux années plus tard, il rentre au TNA avec Lamari comme salarié, participant entre autres, à un gala donné à Shiraz(Iran), très vite il se retira du TNA. En 1970, deux chansonnettes: Ghazali Goudami et Lilah wan cheftou koudami constitueront son premier disque, le grand succès viendra en 1973 avec Djah rebi ya djirani qui le fait connaître au Grand public. Par la suite, c\'est la célébrité avec Mazal khatmi, Ya laâdra win moualik Mériem Mériem. Cette modernisation du chaâbi, certains l\'ont prise à cour tels Mahboub Bati, Mahboub Stambouli, Skandrani, d\'autres l\'accusent d\'avoir dénature le genre.', 4, 'img_artistes/abdelkader chaou.jpg', 1, 179, 155, '2023-12-03 05:40:36'),
(3, 'Abdelkader chercham', '(né en 1946) - Auteur, Compositeur, interprète de Chaâbi. Né à la Casbah d\'Alger. Cet éléve de Hadj M\'hamed El Anka, \"spécialiste\" du genre Djed, trouva une assistance poétique auprès de Hadj Braîhiti. Ce dépanneur - mécanicien a su être, grâce à sa persévérance, un espoir de la chanson chaâbie des années 70.', 4, 'img_artistes/abdelkader chercham.png', 1, 119, 156, '2023-12-03 05:40:36'),
(4, 'Abdelkader guessoum', '(né en 1946 - 12 juillet 2010) - interprète de Chaâbi.\r\nNé le 12 avril 1946 à Blida, il jouait du Ney, du pipo et de l\'harmonica déjà à l\'âge de 8 ans.\r\nSa première mandoline fut acquise avec l\'atmosphère de joie et de ferveur de l\'indépendance.\r\nIl grattait et fredonnait les airs de Hadj M\'Rizek, et Bellah ya chemaâ de Hadj Mahfoud.\r\nAprès une formation bien remplie à l\'école de cheikh Salhi (Mahieddine Mohamed), neveu de Cheikh Mahfoud, lequel le sollicitait en qualité de musicien au sein de sa formation, lors des fêtes familiales.\r\nIl constitue en 1966 son premier orchestre en cachette par respect pour ses maîtres.\r\nIl fut présenté aussi pour la première fois, en 1966, à la radio, par Rabah Driassa et ce fut un essai raté.\r\nTrès déçu, il ne revient sur la scène qu\'en 1969, à l\'occasion du festival de la chanson chaâbie où il obtient le premier prix en interprétant Djel EL Koul Bach yendhekar.\r\nAprès, c\'est la télévision où il anime son premier concert en 1970.\r\nA l\'époque, il était soutenu et encouragé par les maîtres Boualem Djenadi, Dahmane Benachour, Mohamed Misraoui et surtout Rachid Mohamed.\r\nEn 1974, il enregistre deux 45 t et deux ans plus tard, il réalise son premier album (45 t) à paris, grâce à l\'aide que lui apporte Mustapha Skandrani.\r\nAvec Mahboub Bati, il tente sa première expérience - réussie d\'ailleurs - dans le monde de la chansonnette à l\'exemple de Ya H\'la et Ach bih hajbi.\r\nTout de suite après, c\'est l\'éclipse. L\'artiste voulait se reposer, prendre du recul et réfléchir sur sa production.\r\nEn 1989 et après mûre réflexion, il monte sa propre maison d\'édition EL-Alhan où il enregistre ses propres chansons et ceux d\'autres artistes comme TOUBAL, Nacerdine Benghali, Oujdi ect.\r\nSa série de cassette (4 volumes) dans laquelle il reprend les fameux El Kawi, M\'Sebarni Li tihame, Lahbab Amlou Louila, Chehlet Laâyani a eu un franc succès.\r\nBlida est un foyer culturel où plusieurs genres musicaux coexistent. Plusieurs personalités ont pratiqué correctement le chaâbi telles que Mohamed Misraoui, Mohamed Semmad dit M\'rizek, etc.\r\nGuessoum forgera son propre genre à partir de la structure mélodique andalouse hawzi et chaâbi dans le style EL-ANKA.\r\nMustapha Kechkoul l\'abreuva de ses conseils, Cheikh Boualem El-Djenadi de Boufarik lui a permis d\'enrichir son répertoire et Dahmane Benachour et Hadj Mejbeur lui furent d\'un grand apport. ', 4, 'img_artistes/abdelkader guessoum.jpg', 1, 45, 151, '2023-12-03 05:40:36'),
(5, 'Abdelmadjid meskoud', '(né en 1953) - Interprète de Chaâbi. Né le 31 mars 1953 à El Hamma à Belcourt (Alger), Abdelhadjid Meskoud qui n\'a jamais fait d\'école de musique, commence en 1969 à gratter sa première guitare tout en s\'exercant à la comédie d\'abord dans la troupe Mohamed Touri de la Place du 1er Mai que dirigeait Mohamed Tahar Benhamla ensuite dans la Troupe du Théâtre Populaire (TTP) qu\'animait Hassan El-Hassani. Meskoud passe deux ans à Béchar - service national oblige - ce qui lui a permis de chanter juste et maîtriser la frappe. Il reste un chanteur de quartier même si grâce à l\'amitié et à la complicité de Mohamed Er-lkachid, un féru d\'histoire musicale, il arrive à passer à la television. Ses acrivités se limitent à la célébration des mariages jusqu\'au jour ou la belle chanson d\'El-Assima le révèle au grand public, en 1989. Ce texte personnel qu\'il a toutefois commencé à chanter depuis 1987 dans les fêtes est un beau texte, intense, vrai et plein de nostalgie. A l\'origine de ce petit chef d\'oeuvre, la destruction, pour rénovation, du vieux quartier d\'El-Hamma ou il est né. il n\'a pas pu tenir le coup lorsqu\'il a vu la grande boule en fer écraser sa maison. Aprés, le poéme a pris progressivement de l\'ampleur pour donner Dzayer ya Assima. Son orchestre composé de Krimo Ben Allaoua, Hakim Ben El-Djouzi, Zouhir Djemaî (violon), Redouane Ben El-Djouzi (guitar), Ahmed Berrour (derbouka) et Abdelkader Dali (tar), assez stable, a été crée en 1984. Cet artiste qui écoute énormément Brel, Piaff, Brassens et Ferré, qui a beaucoup d\'estime pour les maîtres Hasnaoui et El-Anka notamment, a introduit un peu de fraîcheur dans la chanson chaâbie des années 90 écrasée par d\'autres genres plus agressifs tel que le rai.', 4, 'img_artistes/abdelmadjid meskoud.jpg', 1, 53, 151, '2023-12-03 05:40:36'),
(6, 'Abdelmalek imansourane', '(né en 1955- 07/02/2010) - Interprète et compositeur. Né a El Madania (Alger). Il apprit, à l\'âge de 10 ans, a chanter le genre \"hindou\" qui l\'envoûtait comme tous les jeunes de son âge. Il commence sa carrière artistique en 1980 en interprétant la chanson Galou Ladrab Galou au cours de l\'emission Alhane Oua Chabab. Il connaît un grand succès populaire en 1983 en sortant chez \"Saouf El Andalib\" une cassette audio intitulée Qesset el ghouleme qu\'il fait suivre de plusieurs autres productions, toutes populaires jusqu\'au jour ou il devient lui-même éditeur. Il adhère, pour parfaire ses connaissances en andalou, à l\'Association El Fen Wal Adeb que dirige Mohamed Boutriche, avec ses deux fils Nacerdine et Mustapha. Il s\'inspire surtout du patrimoine, compose lui-même ses danses et mis a part Qesset Sidna Youcef dont il était co-auteur avec le poète Ahmed Berrar, il écrit lui-même le texte de ses chants.', 4, 'img_artistes/abdelmalek imansourane.jpg', 1, 58, 151, '2023-12-03 05:40:36'),
(7, 'Abdelrezak bougataya', 'À compléter', 4, 'img_artistes/abdelrezak bougataya.jpg', 1, 56, 151, '2023-12-03 05:40:36'),
(8, 'Abderahmane elkoubi', 'À compléter', 4, 'img_artistes/Abderrahmane El-Kobbi.jpeg', 1, 48, 151, '2023-12-03 05:40:37'),
(9, 'Alice fitoussi', 'Alice Fitoussi est une chanteuse algérienne d\'origine juive, née le 9 mai 1916 à Bordj Bou Arreridj et décédée en 1998 à El Biar. Son père, Rahmim Fitoussi est un chanteur et violoniste réputé. C’est auprès de lui qu’elle apprend le chant et grave son premier disque à l’age de treize ans1, c\'était la seule chanteuse juive qui interprétait al-Madih. Après l\'indépendance, elle a décide de rester vivre en Algérie, n’allant en France que pour passer l’hiver. <>Source: http://fr.wikipedia.org/wiki/Alice_Fitoussi<>', 4, 'img_artistes/alice fitoussi.jpg', 1, 41, 151, '2023-12-03 05:40:37'),
(10, 'Amar El Achab', '(né en l932) - Maître du Chaâbi. Né le 31 juillet 1932 à Alger, il fut l\'une des figures de la chanson chaâbi des années cinquante et soixante avant de quitter Alger pour la France où il vit toujours (1996). Jeune coursier d\'une teinturerie de Belcourt au cours de ses va-et-vient incessants nécessités par son emploi ingrat, il ne cessait pas de fredonner des chansons. C\'est qu\'à l\'époque, il avait un grand ami poissonnier de son état, au demeurant chef d\'orchestre réputé sur la place, Mouloud Bahri qui l\'avait pris en sympathie, car il est le premier à avoir découvert avec quel talent Amar Lachab préludait aux Oeuvres Classiques. Au cours d\'une fête, Amar Lachab découvrait à son tour les possibilités musicales du poissonnier chef-d\'orchestre. L\'un et l\'autre, décidèrent d\'un commun accord de travailler ensemble: La carrière du chanteur s\'amorçait. Pendant un an, Amar joua de la derbouka à l\'occasion des fêtes et de mariages, acquérant les connaissances de son premier maître et les rudiments d\'une technique nécessaire à l\'exercice du métier auquel il se destinait. c\'est durant cette année qu\'il apprît Alla R\'Soul El Hadi qui devait être suivie par Moulat Et-tadj. Dès lors, invité à son tour, il vole de ses propres ailes et s\'améliore sans cesse au contact de cheikh Namous et Sid Ali Snitra qui lui dispensèrent leurs conseils. Il commençait à se faire un nom. C\'était en 1952, date à laquelle la radio le sollicite pour une émission en direct de trois quarts d\'heure. Surmontant son trac, il chante. C\'est un pas décisif pour le succès. concrétisé quinze jours plus tard par. une seconde convocation de la radio qui le confronte au public en compagnie de l\'orchestre de Skandrani. Son interprétation de Brahim El Khalil lui ouvre des perspectives nouvelles en lui donnant conscience de sa propre valeur artistique. Dounia, une prestigieuse maison d\'édition lui enregistre, en 1953, sur 78 T, une chanson, Mellah Ana Berkani, dont il est l\'auteur. Trois ans plus tard, il signe chez Pathé Marconi Ya Bélaredj, un titre qu\'il interprète sur le mode hawzi. Le texte dont on ignore l\'auteur, connaît un grand succès et suscite même une controverse en raison de son substrat érotique que laisse suggerer le refrain. Cigogneau au long cou / Habitant sur la deuxième terrasser de / Ne va pas paître dans le jardin / De la maîtresse... La chanson sera d\'ailleurs reprise avec autant de succès par la grande chanteuse Fadèla Dziria avec qui Amar Lachab se lie d\'amitié et pour qui il écrit de nombreux morceaux. En 1966, ayant toujours le souci de se perfectionner, il décide d\'aller apprendre le solfège au Conservatoire. Lachab poursuit sa percée avec des chants remarquables par le verbe pur, traduisant directement les maux d\'amour et de société, et leurs mélodies blues sur le fond, dansantes sur la forme. Celui qui a un fort penchant pour le malouf constantinois, l\'auteur de Ya laïm lech tloumni et masbarni la Tihane opte pour l\'exil volontaire en France en l976. Il y donna de nombreux concerts et enregistra, entre autres, un 33 T comprenant six chansons dont Qoulouli ya nais, Triq elli détni, hiya eli trodni, et des reprises Zoudj h\'djoub, Sghier wana chibani. Lachab possède en outre un bon répertoire de chansonnettes courtes et rythmées qu\'il exécute surtout lors des mariages. Son dernier enregistrement à la télévision algérienne date de 1980. Il dispose de 33 enregistrements inscrits à la discothèque centrale de la radio algérienne mais seulement quelques uns à la TV . Toutefois sa discographie est importante: plus d\'une cinquantaine de microsillons 45 T et cassettes audit. L\'écoute de son œuvre laisse apparaître un penchant pour le verbe pur, classique, moralisateur.', 4, 'img_artistes/amar el achab.jpg', 1, 40, 151, '2023-12-03 05:40:37'),
(11, 'Amar ezzahi', 'Une des plus grandes voix du Chaâbi algérien, Amar Ezzahi était connu pour son style unique et sa maîtrise du mandole.\r\n(né en 1941 - 30-11-2016) - Brillant auteur et interprète de Chaâbi. De son vrai nom Amar Aït Zaï, Ezzahi est né le 1er janvier 1941 à Ain El Hammam (Tizi-Ouzou). C\'est en écoutant Boudjemaâ El Ankis, dans les années 60, qu\'il aima le chaâbi. En 1963, il rencontre cheikh Lahlou et Mohamed Brahimi dit cheikh Kebaili qui l\'encouragent, lui remettent d\'anciennes qacidate tout en lui donnant des conseils sur le rythme avec lequel ses textes étaient chantés. Autodidacte, il apprendra le chaabi sur le tas. Il aura la chance d\'avoir, dans son orchestre, durant quinze ans, un musicien de talent qui lui a transmis plusieurs qacidate, il s\'agit de cheikh Kaddour Bachtobdji avec lequel il a commence à travailler en 1964. Son premier enregistrement date de 1968, Ya djahel leshab et Ya el adraâ furent les deux premières chansons de son premier 45t. La musique et les paroles étaient de Mahboub Bati. En 1971, il enregistre trois 45t et en 1976, deux 33t. II compte trois chansons à la radio et quatre autres à la télévision. Son unique cassette Ya rab El I bad sort en 1982. Modeste, réservé, se confiant rarement, fréquentant souvent le café \"El Kawakib\", Amar Ezzahi, l\'un des plus brillants interprètes du chaabi des années 70, disparaît pratiquement de la scène artistique à partir de 80 et n\'est présent que lors des fêtes familiales. Il réapparaît le 10 février 1987 dans un récital à la salle Ibn Khaldoun à Alger pour s\'effacer à nouveau.', 4, 'img_artistes/amar ezzahi.jpg', 1, 35, 151, '2023-12-03 05:40:37'),
(12, 'Amina zouheir', 'À compléter', 4, 'img_artistes/amina zoheir.jpg', 1, 32, 150, '2023-12-03 05:40:37'),
(13, 'Aziouz Rais & Hassiba', 'À compléter', 4, 'img_artistes/aziouz rais & hassiba.jpg', 1, 29, 150, '2023-12-03 05:40:37'),
(14, 'Aziouz rais', '(né en 1954) - Interprète de Chaâbi. Né le 25 août 1954 à la Casbah d \'Alger. Ses premières chansons datent de 1969. Après des débuts laborieux, il arrive à s\'imposer à partir des années 90. Anime les fêtes familiales et enregistre des K7. Chefte H\'mama, Ya houbi, Hbak ghamama dont les paroles et les musiques sont de Rachid Benani figurent dans sa K7 de 1994.', 4, 'img_artistes/aziouz rais.jpg', 1, 29, 151, '2023-12-03 05:40:37'),
(15, 'Bestani bilel', 'À compléter', 4, 'img_artistes/bestani bilel.jpg', 1, 28, 150, '2023-12-03 05:40:37'),
(16, 'Abdelkrim bouaziz', 'À compléter', 4, 'img_artistes/abdelkrim bouaziz.jpg', 1, 45, 150, '2023-12-03 05:40:37'),
(17, 'Boudjemaa elankis', 'né en 1927 - 2015) - Maître du Chaâbi. Né le 17 Juin 1927 à Alger, 1 ère Impasse du Palmier, Bir-Djebbah à la Casbah, au sein d\'une famille pauvre et nombreuse. Mohamed Boudjemaâ est originaire du village Ait Arhouna, commune de Tigzirt-sur-Mer. Son père était coursier et magasinier chez le parfumeur Lorenzy. Le jeune Mohamed, inscrit a l\'école Brahim Fatah, obtient son certificat d\'études primaires en 1939 a l\'âge de onze ans et commence a travailler chez son oncle Hassaîne Boudjemaâ, propriétaire d\'une crémerie, avant de rejoindre Sid Ahmed Serri, un autre mélomane au greffe de la cour d\'Alger. De 1939 à 1945, Mohamed Boudjemaâ qui rêve déjà de devenir El Ankis - El Anka était d\'ailleurs originaire d\'un village voisin de celui du jeune chanteur - s\'essaie à la mandoline puis a la guitare, tout en écoutant et en enregistrant les grands maîtres. Mais il a fallu attendre 1957 pour qu\'il s\'initie à l\'arabe aidé par un oncle paternel. Grâce aux leçons de Chouiter et de Mohamed Kébaili, dont la troupe travaillait sous l\'égide du PPA à la fin des années 30, il fera la connaissance d\'artistes tels que cheikh Said El Meddah, aussi prestigieux à l\'époque que Mustapha Nador. En 1942, l\'apprenti qu\'il était exécutera, pour la première fois en public, à l\'occasion d\'un mariage, halla Rssoul El Hadi Salli Ya Achiq. Dans une troupe créée en 1945, Boudjemaâ évolue entre El Anka et Mrizek, les deux monstres sacrés de l\'époque. Il débute avec un répertoire de mdih comprenant essentiellement les qacidate Chouf li Ouyoubek ya Rassi, Ya Ighafel, Ya Khalek lachia, Zaoubna fi H\'mak et El Baz, des poètes Ben Mssayeb, Ben Sahla, Bentriki, Benkhlouf, Kaddour El Allaoui et Driss El Amir. Toutefois, une part importante du répertoire d\'El Ankis lui fut transmise au début de la Seconde Guerre mondiale par Cheikh Said El Meddah, son voisin à notre Dame d\'Afrique. Grisé par le succès, il se met a faire un travail personnel d\'arrangement musical et, au milieu des années 50, il se lance dans la chansonnette. Tal al Djaffa, El Kawi, Goulou lichahlat ayyani sont les principaux titres de cette expérience qui tourna court du fait que la maison Philips dont le directeur artistique était Boualem Titiche, lui refuse ses ouvres. Découragé, il décide de ne plus chanter, casse son mandole et s\'engage comme gardien d\'un HLM à la cite Climat de France. C\'est aussi la guerre de libération qui commence. Il ne fut pas épargné parce qu\'il sera arrêté et torturé, à deux reprises par les services spécialisés de l\'armée coloniale, en 1957 et en 1960. Sa sortie de prison coïncide avec une reprise, mais plus celui de la chansonnette. Djana El Intissar dont il est l\'auteur des paroles et de la musique évoquant les manifestations du 11 décembre 1961 est un hymne à l\'indépendance. La jeunesse algérienne explose après tant d\'années de servitude et recherche le rythme. Pour la cibler, Boudjemaâ El Ankis fait appel à Mahboub Bati et des 1963, la \"guerre\" éclate : au lieu et place du chaâbi dur et pur, lourd et difficile à comprendre, le duo ressuscite la chansonnette. Le marché et les ondes sont bombardés d\'une soixantaine de tubes à succès dans la veine des Tchaourou \'Alia, Rah El Ghali Rah, Ah ya Intiyya. Le secret de la réussite; des mots simples, du rythme et des thèmes qui traitent des préoccupations des jeunes. Le créneau sera exploité par des chanteurs plus jeunes tels que Amar Ezzahi, Guerouabi, Hassen Said et El Achab, mais le genre - la chansonnette- connaîtra son summum en 1970 et amorça son déclin a partir des années 80. Grâce à l\'instruction, aux progrès de l\'arabisation, le chaâbi classique reprend le dessus et El Ankis abandonne la chansonnette et renoue avec les qaca\'id . Son répertoire compte plus de trois cents chansons allant du medh et du Tajwid au djed en passant par la chansonnette.', 4, 'img_artistes/boudjemaa elankis.jpg', 1, 28, 150, '2023-12-03 05:40:37'),
(18, 'Chaabi dialna', 'À compléter', 4, 'img_artistes/chaabi dialna.png', 1, 33, 152, '2023-12-03 05:40:37'),
(19, 'Cheikh ghaffour', 'Né le 5 mars 1930 à Nedroma (près de Tlemcen), Mohammed Ghaffour rejoint, après un bref passage à l\'école, l\'atelier artisanal de son père el hadj Mekki, tisserand. En 1948, son oncle el hadj Meffouk, drabki (percussionniste) remarque son aptitude vocale et l\'encourage à s\'intégrer à l\'un des nombreux groupes musicaux de la ville. Il débuta alors dans celui de Hadj Mohammed Ghenim Nekkache en s\'initiant à la derbouka, puis à la mandoline. Quelque temps après, il fut admis au sein de l\'orchestre de Cheikh Si Dris Benrahal au sein duquel il demeura jusqu\'en 1955 date à laquelle les nedromis cessèrent de célébrer les mariages en grande pompe en raison de leur mobilisation collective dans la lutte contre l\'occupation coloniale. Au cours de son apprentissage auprès de ce grand Maître, il s\'initia à l\'interprétation des chefs-d\'œuvre des grands poètes de Nedroma tels que Sidi Mohamed Remaoun et Sidi Kaddour Benachour Ez Zerhouni et de Tlemcen tels que Bensehla, Ben M\'Saib, Bentriki et autres.\r\n\r\nLa personnalité qui a conservé à Nedroma d\'après l\'indépendance certains aspects les plus représentatifs de sa citadinité est sans conteste Cheikh Ghaffour qui, de chanteur local, a acquis au fil du temps une envergure et une renommée nationales et internationales. C\'est ainsi que le Président de la République algérienne [Abdelaziz Bouteflika l\'interpelle nommément et publiquement quand il exhorta de Tlemcen les \"rossignols\" d\'Algérie à reprendre leur chant.\r\n\r\nEl Hadj Mohammed Ghaffour appartient à une famille de vieille souche nédromie, d\'origine andalouse. Il fréquente le djama\' ou mcid de Sidi Mhammed Zrihni - Lakhdari à l\'état civil, situé au quartier Derb El Kherba, non loin de chez lui. La zaouia (confrérie) Azziania, fondée par Sidi M\'Hammed Ben Abderrahmane Ben Abi Ziane de Kenadsa près de Béchar a fortement marqué son éducation spirituelle et sociale.\r\n\r\nIl va fréquenter sa vie durant les zaouia et s\'imprégner de leur enseignement et de leurs pratiques mystiques. Comme tout tisserand, il aimait chanter en lançant prestement la navette et en manœuvrant les pédales de son métier à tisser, pour fabriquer couvertures et hambals en laine, en usage à Nedroma.\r\n\r\nMohammed Ghaffour a fait partie de l\'orchestre de Cheikh Si Driss Benrahal comme drabki, parmi d\'autres musiciens bien connus comme Cheikh Lakhdar Ez zrihni Lakhdari, Hadj Ahmed H\'Souna Ghomari, Miloud Taleb, Si Ali Dinedane et les deux frères Ahmed Charef et Lakhdar Tekkouk .\r\n\r\nAprès le décès de Si Dris, Mohammed Ghaffour forma son propre orchestre qui prend comme lieu de répétition une petite masria au-dessus du magasin occupé actuellement par Mouffok Selles, mais il n\'eut aucune activité jusqu\'en 1962.\r\n\r\nÀ l\'indépendance de l\'Algérie, Cheikh Mohammed Ghaffour, encouragés par ses admirateurs et notamment M\'hammed Bouri, reconstitue son orchestre et commence à animer les soirées de mariages en imprimant un cachet nédromi à la musique andalouse par ses noubas plus légères et moins académiques que celles de Tlemcen, ainsi que par ses qacida d\'auteurs renommés. Après une la participation au festival de la musique andalouse de 1967 à Alger, Cheikh Mohammed Ghaffour baptise son groupe du nom de El Moutribia El Mouahidia.\r\n\r\nAprès cette participation fort honorable et sa révélation au public à l\'échelle nationale, la carrière de Cheikh Mohammed Ghaffour va prendre sa vitesse de croisière après son remarquable succès au cours du festival de musique populaire en 1969 à Alger dont il obtint le premier prix grâce à sa magistrale interprétation de la sublime qacida de Cheikh Kaddour Benachour Ez Zerhouni, Welfi Meriem, pourtant chantée avant lui par Cheikh Hammada et Cheikh Mhammed El Anka. Il faut ajouter que c\'est grâce à l\'apport et au talent de l\'ensemble des membres de son groupe, notamment Cheikh Abdesselem Khiat avec sa voix sans pareille et sa prodigieuse mémoire des mélodies et des textes, que Cheikh Ghaffour a connu la consécration.\r\n\r\nEn effet, sans ses merveilleux compagnons, Cheikh Ghaffour ne pouvait atteindre le niveau de succès qu’il a atteint. Ils n’étaient pas nombreux ; ils dépassaient rarement le nombre de sept, mais chacun d’eux était un virtuose dans la maîtrise du chant et de l’instrument dont il jouait. Dieu a voulu que la plupart d’entre eux soient rappelés à Lui. C’est ainsi que Cheikh Abdesselem Khiat, Noureddine hassani, Ahmed Bouanani dit Elhsini, Abderrezak Debbouza, Bouziane Ghomari, Zine Elabidine Khelifa, Benamar Koriche, Boubakkar Yagoubi et Mohammed Kheireddine Midoune ne sont plus de ce monde. Le dernier survivant est Cheikh Bejaï Ghaffour, qui ne fait plus partie du groupe actuel de son frère Cheikh Mohammed, mais il continue à être invité à animer des soirées de mariage à la tête d’un groupe de jeunes.\r\n\r\nSi Cheikh Mohammed Ghaffour a réussi à connaître la gloire en tant qu’interprète et chef d’orchestre et à subvenir aux besoins de sa famille, il a échoué dans le rôle qui lui incombait, à la tête de l’Association El Moutribia El Mouwahidia, celui de créer l’école de musique qui n’existe toujours pas à Nédroma. Contrairement aux diverses sociétés musicales de Tlemcen et d’ailleurs qui se sont concrètement investies dans la formation et la révélation de nouveaux talents pour perpétuer la conservation du patrimoine musical national, Cheikh Mohammed Ghaffour n’a impulsé aucune action de formation dans le cadre de son association, au profit des jeunes de Nédroma, en dépit des aides notables qu’il a souvent reçues pour ce faire des entreprises publiques. De plus, il s’est toujours obstiné à refuser les offres des maisons d’édition de l’enregistrer et d’assurer la diffusion de ses succès. Hormis un enregistrement dans un des disques faisant partie de la compilation éditée à la suite du Festival de musique populaire, il ne laissera aucun disque à la postérité si l’on excepte les enregistrements audiovisuels effectués par la Télévision nationale.\r\n\r\nÀ son âge actuel, avec sa mémoire déclinante, et en l’absence de son valeureux groupe d’antan, Cheikh Mohammed Ghaffour n’est plus que l’ombre de lui-même. Il est trop tard pour lui, aussi bien pour produire une compilation valable de ses succès que pour créer un établissement d’enseignement musical à Nédroma. Sa présence actuelle au sein de l’APW n’a en rien servi la culture en général et la musique en particulier, car les autorités locales n’ont rien fait à ce jour pour doter les villes de la Wilaya d’écoles de musique dignes de ce nom.\r\n\r\nFaute pour lui de bien couronner sa vie d’artiste en formant des continuateurs, Cheikh Mohammed Ghaffour a choisi d’interrompre sa carrière et de ne rien faire sinon s’immerger dans la pratique des rites mystiques en se réclamant de la voie qui était celle du grand poète Cheikh Kaddour Benachour Ez Zerhouni qu’il reconnaît et vénère comme un grand Saint, à l’instar de ses disciples tlemceniens, . N’est-ce pas lui qui a érigé, à ses frais, le mausolée qui abrite à présent sa tombe au cimetière de Nédroma ?\r\n\r\nLa modestie de El Hadj Mohammed Ghaffour est exemplaire: \"j\'ai chanté parce qu\'un jour Cheikh Ghenim me l\'a imposé ... J\'ai continué à le faire parce que cela me plaisait. J\'ai persisté parce que cela plaisait aux autres ...\"\r\nsource => https://fr.wikipedia.org/wiki/El_Hadj_Mohamed_El_Ghaffour', 4, 'img_artistes/cheikh ghaffour.png', 1, 28, 150, '2023-12-03 05:40:37'),
(20, 'Dahmane el harrachi', 'A travers ses chansons composées dans les années 50. Dahmane El ­Harachi incarnait la modernité au sens baudelairien du terme, c\'est-à-dire non pas \"le triomphe du nouveau, la glorification du progrès ou la suprématie des avant-gardes\" mais le besoin de retrouver \"la morale et esthétique du temps\". Le parcours artistique d\'EI-Harachi porte la marque de son vécu et traduit toutes les déclinaisons de l\'Immigritude\". Observateur attentif et vigilant du milieu de ces travailleurs appelés à \"construire des maisons qu\'ils n\'habiteront jamais\" ou des autoroutes qu\'ils n\'emprunteront pas. Dahmane (diminutif d\'Abderrahmane) a toujours évité de tomber dans le misérabilisme alors ambiant. Ce que contredisait un peu sa vie dissolue, mais il disait des choses à la fois vraies et belles car c\'était un pessimiste gai. Bâtie autour du Chaâbi, genre populaire de la Casbah d\'Alger. La musique d\'EI-Harachi a gardé certaines lignes mélodiques pour les notes et une nette pro pension aux proverbes et aux dictons puisés dans la tradition poétique orale quant aux mots. Le chaâbi tel qu\'il a été \"institué\" par El-Anka regorgeait d\'allégories émises en semi-dialectal et de citations pompées dans le \"melhoun\", celui de Dahmane use d\'un parler simple de tous les jours, compréhensible par l\'ensemble de la communauté maghrébine. Ce qui explique, en partie, son large succès. Né le 7 juillet 1925 à El Biar, un quartier résidentiel d\'Alger. El ­Harachi, de son vrai nom Amrani, a grandi a EI-Harrach (ex-Maison Carrée), dans la banlieue algéroise. Son père, Cheikh EI-Amrani, était le muezzin de la Grande Mosquée de la capitale algérienne et il a élevé son fils dans le respect des principes musulmans, complétés par ceux dispensés par l\'école coranique et l\'école primaire qu\'il suivra Jusqu\'à l\'obtention du certificat d\'études, diplôme a l\'époque comme un excellent sauf-conduit pour le marché de l\'emploi. Le jeune homme s\'essaiera plutôt à l\'exercice de métiers divers dont la cordonnerie et pendant sept ans, le boulot de receveur de tramway sur la ligne EI-Harrach-Bab-et-Oued. C\'est au cours de cette période qu\'il entame quelques prometteurs débuts musicaux, intégrant une troupe d\'amateurs et donnant des concerts un peu partout en Algérie. En 1949, il se rend en France et s\'installe d\'abord à Lille, puis à Marseille et enfin Paris qu\'il ne quittera pratiquement plus. C\'est dans les cafés, embués par les vapeurs éthyliques de la nostalgie qu\'il se produit régulièrement. Dans ces endroits-tremplins, où l\'on vient humer l\'air du « pays », Dahmane, qui est un impressionnant instrumentiste (il était un virtuose du banjo), chante de sa voix rocailleuse, modulée par l\'alcool et le tabac, les classiques du chaâbi et surprend par son interprétation hors des sentiers battus. Élégant, bonne gueule d\'atmosphère et buveur, le blues-man des faubourgs séduit, bouleverse et remue les consciences. Surnommé « Aznavour » dans le milieu artistique alors qu\'il est à comparer aux chantres du bleu à l\'âme du delta du Mississipi. Dahmane s\'imposera définitivement par ses propres compositions hantées par la silhouette d\'Alger la Blanche, les visions de femmes possédant la grâce d\'une perdrix et la finesse d\'une colombe ou l\'effroi suscité par \"la plus haute de solitudes\", du au déracinement. Découvert sur le tard par la nouvelle génération. EI-Harachi a eu droit à sa première scène digne lors du Festival de la Musique maghrébine qu\'il s\'est tenu à la fin des années 70 à la Villette. En Algérie, terre qu\'il n\'a jamais cesse d\'évoquer à sa façon joliment imagée, il fera deux apparitions avant de connaître une fin tragique, le 31 août 1980. dans un accident de voiture sur la corniche algéroise qu\'il sublimait par-dessus tout. De Dahmane, il nous reste un vaste répertoire, dont vous retrouverez ici quelques extraits significatifs et un documentaire réalisé par Hadi Rahim pour la télévision algérienne (intitule: \"Saha Dahmane\", traduction: \"Merci Dahmane\"), relevant toute la truculence du personnage. Récemment, Rachid Taha lui a rendu hommage en reprenant un de ses titres majeurs: \"Ya Rayah\" (\"Candidat a l\'exil. Tu auras beau voyager où tu veux un jour tu reviendras à ton point de départ.\") En un chant bref comme il avait coutume de le faire. Dahmane a su résumer le cours d\'une destinée, La sienne. Rabah Mezouane', 4, 'img_artistes/dahmane el harrachi.jpg', 1, 29, 150, '2023-12-03 05:40:37'),
(21, 'El Hachemi Guerouabi', '(né en 1938 - 2006) - Maître du Chaâbi. Né le 6 janvier 1938 à El Mouradia (Alger), il grandit à Bélouizdad (ex-Belcourt) où deux passions occupent son temps : le football et la musique. Bon ailier droit, il jouera sa dernière saison en 1951-52, sous les couleurs de la Redoute AC. Au début des années 50, il commença à s\'intéresser à la musique et tout particulièrement à El-Anka, M\'rizek, H\'ssissen, Zerbout et Lachab. Au music hall El Arbi, il se distingue en obtenant deux prix. Grâce à Mahieddine Bachetarzi, il rejoint l\'Opéra d\'Alger, en 1953 à 1954, ou il chantera Magrounet Lehwahjeb qui fut un sucées. Engagé à l\'Opéra comme chanteur, il fera aussi de la comédie et jouera dans plusieurs pièces et dans de nombreux sketches dont Dahmane la chaire et Haroun Errachid. Après l\'indépendance, il rencontre Mahboub Bati avec lequel il enrichit ses connaissances, se perfectionne et enregistre des chansonnettes. En 1962 et face à l\'invasion des chansons occidentales et égyptiennes, il fallait trouver une place pour le chaâbi auprès des Jeunes. Guerouabi introduit des changements sur le genre et, avec EI barah, il aura beaucoup d\'impact. Dans ce courant rénovateur auquel s\'opposeront les conservateurs, on trouvera aussi El Ankis et bien entendu le compositeur Mallboub Bati. Toutefois, El harraz et Youm EI Djemaâ ont la préférence de Guerouabi qui excelle d\'ailleurs dans le mdih et les nabawiyates. Il effectue un pélerinage à la Mecque en 1987. Guerouabi qui a commencé à taquiner la mandale à l\'âge de neuf ans a accumulé un capital immense grâce au contact et au travail assidu auprès de nombreux maîtres du genre. Toutefois son prestige découle du fait qu\'il a su apporter sa touche personnelle et broder une variante singulière sur l\'étoffe commune qu\'est le chaâbi. Il n\'a jamais cessé en fait, même pendant les moments difficiles de sa carrière, d\'être à la hauteur de sa réputation, qui a largement dépassé les frontières nationales. A son actif, des centaines de compositions, dont des adaptations de poèmes des XVI Iè et Xvlllè siècles. Il en courage son fils Mustapha à le suivre sur le même chemin et chanter en duo avec lui en 1990. Héritier populaire des grands maîtres du genre et figure emblématique de toute une génération, il renoue avec les textes fiévreux et les poésies qui ont fait sa renommée, dès et début des années 50. La voix suave légèrement éraillée, le \" rescapé\" Algérois d\'une musique qui s\'évaporait de plus en plus dans la variété refait, au début des années 90, un retour éblouissant avec un CD sorti chez Sonodisc, en France, Le chaâbi des maîtres. Cithare, piano, tablas, violons, banjos et guitare constituent l\'instrumentation d\'un répertoire classique revitalisé et toujours distillé en arabe dialectal, avec une diction et une sérénité extraordinaires.', 4, 'img_artistes/el hachmi guerouabi.jpg', 1, 63, 151, '2023-12-03 05:40:38'),
(22, 'Elhadj el anka', '(1907-1978) - Grand maître de la chanson Chaâbi. De son vrai nom Aît Ouarab Mohamed Idir Halo, Hadj M\'Hamed El Anka naquit le 20 mai 1907 à la Casbah d\'Alger, précisément au 4, rue Tombouctou, au sein d\'une famille modeste, originaire de Béni Djennad (Tizi-Ouzou). Son père Mohamed Ben HadJ Saîd, souffrant le jour de sa naissance, dut être suppléé par un parent maternel pour la déclaration a l\'état civil. C\'est ainsi que naquit un quiproquo au sujet du nom patronymique d\'El Anka. Son oncle maternel se présente en tant que tel; il dit en arabe \"Ana halo\" (Je suis son oncle) et c\'est de cette manière que le préposé inscrivit \"Halo\". Il devient alors Halo Mohamed Idir. Sa mère Fatma Bent Boudjemaâ l\'entourait de toute l\'affection qu\'une mère pouvait donner. Elle était attentive a son éducation et à son instruction. Trois écoles l\'accueillent successivement de 1912 à 1918 : coranique (1912-1914), Brahim Fatah (Casbah) de 1914 à 1917 et une autre à Bouzaréah jusqu\'en 1918. Quand il quitte l\'école définitivement pour se consacrer au travail, il n\'avait pas encore souffle sa 11 ème bougie. C\'est sur recommandation de Si Said Larbi, un musicien de renom, jouant au sein de l\'orchestre de Mustapha Nador, que le jeune M\'hamed obtenait le privilège d\'assister aux fêtes animées par ce Grand maître qu\'il vénérait. C\'est ainsi que durant le mois de Ramadhan de l\'année 1917, le cheikh remarque la passion du jeune M\'hamed et son sens inné pour le rythme et lui permit de tenir le tar (tambourin) au sein de son orchestre. A partir de la, ce fut Kehioudji, un demi-frère de Hadj Mrizek qui le reçoit en qualité de musicien a plein temps au sein de l\'orchestre qui animait les cérémonies de henné réservées généralement aux artistes débutants. Après le décès de cheikh Nador à l\'aube du 19 mai 1926 à Cherchell, ville d\'origine de son épouse ou il venait juste de s\'installer, El Anka prit le relais du cheikh dans l\'animation des fêtes familiales. L\'orchestre était constitué de Si Saîd Larbi, de son vrai nom Birou, d\'Omar Bébéo (Slimane Allane) et de Mustapha Oulid El Meddah entre autres. C\'est en 1927 qu\'il participa aux cours prodigués par le cheikh Sid AH Oulid Lakehal, enseignement qu\'il suivit avec assiduité jusqu\'en 1932. 1928 est une année charnière dans sa carrière du fait qu\'il rencontre le grand public. Il enregistre 27 disques 78 t chez Columbia, son premier éditeur et prit part aussi a l\'inauguration de la Radio PTT Alger. Ces deux événements vont le propulser au devant de la scène a travers tout le territoire national et même au-delà. Le 5 août 1931, cheikh Abderrahmane Saîdi venait de s\'éteindre. Ce Grand cheikh disparu, El Anka se retrouvera seul dans le genre mdih. C\'est ainsi que sa popularité favorisée par les moyens modernes du phonographe et de la radio, allait de plus en plus grandissante. Des son retour de La Mecque en 1937, il reprit ses tournées en Algérie et en France et renouvela sa formation en intégrant HadJ Abderrahmane Guechoud, Kaddour Cherchalli (Abdelkader Bouheraoua décédé en 1968 à Alger), Chabane Chaouch à la derbouka et Rachid Rebahi au tar en remplacement de cheikh Hadj Menouer qui créa son propre orchestre. Au lendemain de la Seconde Guerre mondiale, et Après une période jugée difficile par certains proches du cheikh, El HadJ M\'Hamed El Anka va être convié à diriger la première grande formation de musique populaire de Radio Alger à peine naissante et succédant à Radio PTT, musique populaire qui allait devenir, a partir de 1946, \"chaâbi\" grâce à la grande notoriété de son promoteur, El Anka. En 1955. Il fait son entrée au Conservatoire municipal d\'Alger en qualité de professeur charge de l\'enseignement du chaâbi. Ses premiers élèves vont devenir tous des cheikhs a leur tour, assurant ainsi une relève prospère et forte, entre autres, Amar Lâachab, Hassen Said, Rachid Souki, etc. EI-Hadj M\'Hamed El-Anka a bien pris à cour son art, il a appris ses textes si couramment qu\'il s\'en est bien imprégné ne faisant alors qu\'un seul corps dans une symbiose et une harmonie exceptionnelle qui font tout le genie créateur de l\'artiste en allant jusqu\'à personnifier, souvent malgré lui, le contenu des poésies qu\'il interpréte; les exemples d\'El-Hmam, Soubhane Allah Yaltif sont assez édifiants. La grande innovation apportée par EI-Hadj El-Anka demeure incontestablement la note de fraîcheur introduite dans une musique réputée monovocale qui ne répondait plus au goût du jour; Son jeu instrumental devient plus pétillant, allégé de sa nonchalance. Sa manière de mettre la mélodie au service du verbe était tout simplement unique. A titre indicatif, El Hadj El Anka a interprété près de 360 poésies (qaca\'id ) et produit environ 130 disques. Après Columbia, il réalise avec Algériaphone une dizaine de 78t en 1932 et une autre dizaine avec Polyphone. Après plus de cinquante ans au service de l\'art, El Anka animera les deux dernières soirées de sa carrière jusqu\'à l\'aube, en 1976, à Cherchell, pour le mariage du petit-fils de son maître cheikh Mustapha Nador et, en 1977, a El-Biar, chez des familles qui lui étaient très attachées. Il mourut le 23 novembre 1978, à Alger, et fut enterré au cimetière d\'El-Kettar.', 4, 'img_artistes/el hadj el anka_2.jpeg', 1, 55, 150, '2023-12-03 05:40:38'),
(23, 'Elhadj mahfoud', 'À compléter', 4, 'img_artistes/el hadj mahfoud.jpg', 1, 42, 150, '2023-12-03 05:40:38'),
(24, 'Elhadj menouar', '	(1913-1971)- Maître du Chaâbi. Né à la Casbah d\'Alger. Issu d\'une famille modeste originaire de Aîn Assila (Bordj Ménaïe), El Hadj Menouar, de son vrai nom Menouar Kerar, dut se mettre très tôt au travail pour faire vivre sa famille: Privé d\'instruction, ne sachant ni lire ni écrire, il était par contre doué d\'une mémoire phénoménale. Emmagasinant des centaines de Qacidas même les plus longues, il devint rapidement une véritable encyclopédie. Il s\'est intéressé très jeune à la musique et fut encouragé par K\'hioudji. Il apprenait tout ce qu\'il entendait auprès des maîtres de son époque tels que Mustapha Driouech, Kouider Ben Smaïl, EI-Ounnas Khmissa, Saïd Laâouar, cheikh Saïdi et d\'autres encore. Deux qualités étaient absolument nécessaires aux chanteurs pour réussir, une mémoire sans faille et une voix puissante. Il n\'était pas question de se présenter au public lisent ses textes. Le micro n\'existant pas, il fallait de la voix pour se faire entendre et s\'imposer au public. Toutes ces qualités Hadj Menouar les possédait. Le chanteur n\'était accompagné à l\'époque que par les instruments de percussion comme le Deff, le Bendir, le tar. Celui qui a introduit des instruments comme le violon, la mandoline, le Qanoun dans le mdih , c\'est cheikh Ben Kouider. Hadj Menouar a conservé de la vieille tradition l\'utilisation du tar pour s\'accompagner; il était le maître incontesté de cet instrument à tel point qu\'il a été surnommé \"le Prince du Tar\" par Ahmed Lakchal qui l\'a introduit à la radio. S\'occupant surtout du Med\'h et se spécialisant longtemps dans les neutres religieuses du genre sa célébrité s\'étendait de jour en jour, il anima de nombreuses fêtes familiales ou publiques, recevant le meilleur accueil auprès de la population qui aimait sa voix forte et mélodieuse. Mahieddine Bachetarzi l\'engagera dans la partie concert de ses tournées théâtrales et le fera connaître dans toutes les régions du territoire. Il a enregistré une dizaine de disques vers les années 50 chez Pathé-Marconi dont une chansonnette qui s\'intitule Khemous alik oue serre aliya, paroles écrites par El-Anka. Nerveux, alerte mais généreux et serviable, il était disponible pour répondre à toutes sortes de questions que lui posaient les jeunes qui venaient au métier. Il était employé pendant longtemps en qualité d\'agent de service à l\'ex- RTA, mais cette dernière n\'a pas tellement, de son vivant, su profiter de ses capacités artistiques. Il avait la particularité de jouer du tar tout en chantant. Il jouait d\'autres instruments, mais il ne l\'exhibait jamais. El-hadj Menouar avait participé, aux côtés d\'El-Hadj El- Anka et Hadj M\'Rizek, à un spectacle organisé au profit de la famille de cheikh Khelifa Belkacem, qui venait de décider le 4 novembre 1951. Le gala a eu lieu le 20 mars 1952 à la salle Ibn Khaldoun (ex-pierre Bordes), l\'animation était assurée par Othmane Boujuetaïa. Il devait interpréter ce soir-là deux chansons: Ya tbib aref daya et A lalla el batoul. Il aimait se produire durant le mois de Ramadhan dans les cafés et préférait chaque année le café de Djamaâ Farès (ex-Djamaâ Lihoud) et celui de Touadjine, dans le quartier de Tijditt à Mostaganem. Il mourut le 7 novembre 1971 à El- Madania (Alger).', 4, 'img_artistes/el hadj menouar.png', 1, 30, 150, '2023-12-03 05:40:38'),
(25, 'Elhadj mrizek', '(1912-1955) - Brillant interprète de Chaâbi. De son vrai nom Arezki Chaïeb, Hadj M\'Rizek naquit au 4, Rue de Thébes à la Casbah d\'Alger. Il fréquenta l\'école \"indigène\" du quartier de Soustara, l\'école Sarrouy où il obtint en 1927, le Certificat d\'Etudes Primaires CEP \"indigène\". Très jeune, il s\'intéressa à la musique. Son demi-frère Mohamed Qhioudji, lui apprit quelques airs de chansons qu\'il interprétait avec des amis. Dans cet orchestre \"familial\" il tenait le tar. En 1928, au cercle du Mouloudia, Place Mahon face à Djamaâ Djedid, existait une société andalouse au sein de laquelle il évolua aux côtés de Cheikh Ahmed Chitane, faisant d\'énormes progrès dans le genre Hawzi tout en suivant parallèlement des cours d\'arabe. C\'est là qu\'il rencontra Mustapha Kechkoul, Omar Hibi et Bencharif. A partir de 1929, il anima la plupart des fête familiales de la Casbah. Ses interprètations du hawzi étaient très appréciées à Blida et Cherchell. Il trouva assez de temps pour aider le Mouloudia dont il fut le vice- président en 1937 et diriger par la suite la section natation. Il a enregistré ses premiers disques à Paris chez Gramophone (78 T) en 1938, entre autres: Ya taha el amine, Yal qadi, EI bla fi el-kholta. Il a effectué son pèlerinage en 1937, une année après El-Hadj El-Anka et Hadj Menouar. En 195l, il se produit à la salle lbn Khaldoun (ex: P. Bordes) avec Lili Bouniche. il a interprèté, El-Faradjiya de Sidi Kaddour El-Alami et Rohi Thasbek ya afdra de Bendebbeh. Le 20 mai 1952, il participe à un grand gala organisé, au profit de la famille du Cheikh Khelifa Belkacem décédé, le 4 novembre 1951. Au cours de la même année il enregistre chez Pacifique son grand succès: El Mouloudia (78 T); les paroles lui étaient écrites par Cheikh Noreddine ainsi que Arassi noussik du poète Dris El-Alami et Qahoua ou lateye du poète Sid Thami El- Medeghri. C\'était un dandy comme on disait à cette époque, gentleman et distingué. Tout comme Habib Rédha, Mustapha Skandrani, Mohamed El-Kamel, Abdelghani Belkaïd, Ali Debbah (dit Allilou) et beaucoup d\'autres, il était très estimé par son public et particulièrement dans le M\'Zab où il animait beaucoup de soirées, Qhioudji son demi-frère, dit Mohand Aromi, a joué un rôte important dans sa vie artistique du fait qu\'il était organisateur de spectacle, il était en fait son imprésario. C\'était lui qui réceptionnait les demandes de galas et fêtes familiales pour choisir les cheikhs disponibles et monter les cérémonies à sa manière, Hadj Mrizek avait entrepris, vers 1940, l\'interprétation de chants religieux. Cheikh Sid Ahmed Ibnou Zekri, proviseur du lycée de Ben-Aknoun l\'a orienté vers le hawzi et l\'Aroubi, genres profanes qui lui allaient bien. Il s\'initia au dur apprentissage de l\'écriture poétique mais la maladie était là. Bien qu\'alité, il s\'enquerrait des nouvelles de la Révolution déclenchée de 1er Novembre 1954. Demi-frère de Rouiched, originaire de Kanis à Azzefoune (Tizi-Ouzou), Hadj M\'Rizek qui avait quitté, à la fin de la Seconde Guerre mondiale, la vieille maison familiale de la Casbah pour le quartier chic européen du Bvd Pitolet à Bologhine, mourut dans la nuit du 11 au 12 février 1955 à Alger, après une longue maladie et fut enterré au cimetière d\'El-Kettar.', 4, 'img_artistes/el hadj mrizek.png', 1, 30, 150, '2023-12-03 05:40:39'),
(26, 'Emir nacer', 'À compléter', 4, 'img_artistes/emir nacer.jpg', 1, 28, 150, '2023-12-03 05:40:40'),
(27, 'Esma djermoune', 'À compléter', 4, 'img_artistes/esma djermoune.png', 1, 28, 150, '2023-12-03 05:40:40');
INSERT INTO `artistes` (`id`, `nom`, `bio`, `user_id`, `image`, `categorie_id`, `views`, `likes`, `created_at`) VALUES
(28, 'Fadila dziria', '1917-1970) - Grande cantatrice. Née le 25 juin 1917 à Djenan Beït El Mel du côté de Notre Dame d\'Afrique, à Alger, dans une famille conservatrice, Fadela Dziria, de son vrai nom Fadila Madani, est l\'une des figures les plus marquantes de la chanson traditionnelle citadine dite Hawzi. Son père s\'appelait Mehdi Ben Abderrahmane et sa mère Fettouma Khelfaoui. Sa seule seour de père et de mère, Goucem, fut musicienne en son temps tandis que les deux autres soeurs et un frère, Amar, ont la même mère seulement. Des son plus jeune âge, elle s\'adonna à la chanson, en imitant la grande cheikha Yamna Bent El Hadj El Mehdi, au sommet de sa carrière et en assistant à toutes les fêtes qu\'elle animait et reprendra un peu plus tard, à son compte, les mélodies de la diva du hawzi. Elle fut découverte par une émission de Radio Alger Men koul Fen chwai de M. E. Hachelafet Djilali Haddad qui lui composèrent un grand nombre de chansons sur le modèle classique et hawzi. Quarante ans plus tard, une partie de son répertoire est présume du domaine public comme Ana Toueiri. Mustapha Kechkoul, discothécaire de Radio Alger, se chargea de son initiation à la musique classique, initiation qui s\'avéra laborieuse car elle était analphabète; il fallait lui souffler les paroles pendant les enregistrements. Soutien majeur de sa famille sur le plan matériel, Fadila s\'était mariée une seule fois, en 1930, à l\'âge de 13 ans, avec un chômeur qui en avait trente. De cette union naquit une fille qui ne vécut pas. Sa mésentente avec son mari, qui décéda quelque temps après, la poussa a faire une fugue et Fadila se retrouva, en 1935 a Paris, chantant dans les quartiers à forte concentration d\'émigrés et plus particulièrement au cabaret El Djazaîr. Elle chantera du Asri (moderne), rencontrera Abdelhamid Ababsa qui lui apprit plusieurs mélodies en vogue à l\'époque et lorsque sa mère la fit revenir, elle restera chanteuse tant sa voix plaisait au public. Elle fut engagée pendant les soirées de Ramadhan au Café des Sports géré par Hadj Mahfoud et situé à la rue Bruce, dans la basse Casbah. Une troupe de théâtre et de variété la prit en charge par la suite. Elle travaillera avec le directeur de la troupe qui lui conseilla de changer de genre. Mustapha Skandrani et Mustapha Kechkoul, bien introduits dans le cercle musical algérois vont beaucoup l\'influencer et elle a fini par adopter l\'Algérois en entrant dans le groupe de Mériem Fekkaî qui animait les soirées de fêtes du tout Alger. Pour son premier enregistrement professionnel, elle reprend une chanson que tous les Algérois connaissaient bien déjà Rachiq el Qalb, un morceau genre Nqleb du mode Araq faisant partie de la structure musicale arabo-andalouse. Elle s\'en était acquittée d\'une façon majestueuse, toutefois, sa vraie rentrée, en 1949, fut avec l\'enregistrement de son premier disque chez Pacific, Mal Hbibi Malou (paroles de Kechkoul et musique de Skandrani), qui obtint un grand succès commercial. Mahieddine Bachetarzi l\'engagea alors pour animer la partie concert de ses tournées. Elle participa aussi en tant que comédienne aux pièces qu\'il présentait à travers toute l\'Algérie et notamment dans Ma Yenfâa ghir Essah, Dawlette Enissa, Othmane en Chine et Mouni Radjel (1949). Cette carrière de comédiennes si elle n\'a pas été longue elle lui valut de vaincre le trac du public et surtout de travailler aux cotes d\'artistes consacres comme Ksentini, Touri, Bachdjarrah, Keltoum et bien d\'autres. Quittant les planches, elle revient à la chanson, sa véritable passion et ce retour lui valut au moins trois grands succès : Malou habibi bien sur mais aussi Ena Toueiri... (paroles de M. E. Hachelafet musique de Djilali Haddad) et Houni Kanou (Ils étaient la), un zendali exécuté sur un rythme typiquement féminin de l\'Algérois. Femme généreuse, pleine de bonté, on la retrouve en 1954 à l\'Opéra de Paris ou elle s\'est produite dans le gala organise au profit des sinistres d\'El Asnam aux côtés de la célèbre comédienne Keltoum et d\'Aouichette, chanteuse bien connue dans le milieu artistique de l\'époque. En 1955, elle participe à des émissions classiques à la télévision algérienne naissante. Sa vie artistique ne l\'empêchera pas de participer avec sa seour Goucem à la guerre de libération : elle était chargée de la collecte des fonds et, à cause de cela fut emprisonnée à Serkadji. A sa sortie de prison, elle forme son propre ensemble musical avec sa soeur Goucem à la derbouka, Reinette Daoud, dite l\'Oranaise, au violon, et sa nièce Assia au piano et a l\'orgue. Après l\'indépendance, elle reprend sa participation à la radio et à la télévision. Sensible, perspicace, Fadila Dziria était majestueuse sur scène. Son langage recherché, serein et calme, son élégance et sa manière de porter le Kaftan, le Karakou avec Séroual doré coiffé d\'un Khit Erroh ou Zrir, faisait d\'elle l\'expression vivante de toute une culture, de toute une tradition jalousement conservée. Elle incarnait aussi le côté classique de la musique algérienne et, à ce titre, elle fut connue partout comme la plus grande cantatrice algérienne. Son caractère affable et son sourire lui ont permis de vivre dans le milieu artistique avec la considération et la sympathie de tous. Elle mourut en son domicile de la rue Hocine Asselah, près de la Grande Poste à Alger le samedi 6 octobre 1970 et fut enterrée au cimetière d\'El Kettar.', 4, 'img_artistes/fadila dziria.jpg', 1, 31, 150, '2023-12-03 05:40:40'),
(29, 'Faycal hedroug', 'Chanteur Chaabi : né en 1964 à Saint Eugene (Alger). Fait ses débuts au sein de l\'UNJA de Bologhine en 1980. Autodidacte, influencé par le Cardinale EL HADJ MOHAMED EL ANKA, puis par BOURDIB KAMEL et enfin par GUETTAF. Present sur la scene artistique, anime Galas, récital et soirées privées.', 4, 'img_artistes/faycal hedroug.jpg', 1, 29, 150, '2023-12-03 05:40:40'),
(30, 'Fella ababsa', 'À compléter', 4, 'img_artistes/fella ababsa.jpg', 1, 28, 150, '2023-12-03 05:40:40'),
(31, 'Fella sghera', 'À compléter', 4, 'img_artistes/fella sghera.jpg', 1, 28, 150, '2023-12-03 05:40:40'),
(32, 'Hamani kenga', 'À compléter', 4, 'img_artistes/webc.jpg', 4, 30, 150, '2023-12-03 05:40:40'),
(33, 'Hamid abdjaoui', 'Auteur, compositeur - musicien et chanteur, \"Chaâbi \" (populaire) algérois. \"Andalous\" et \"Rythmes Kabyles\"... Ce parolier qui est aussi un remarquable narrateur et un compositeur de talent, naquit à Bédjaïa, une ville où se côtoient quotidiennement le bleu azur de la Méditerranée et la teinte blanche des cimes enneigées des montagnes de la Kabylie. Bédjaïa, aux mille évocations si chères à Hamid, fut dans le passé une citadelle mystérieuse et fascinante pour tant de corsaires méditerranéens. Ce site merveilleux qui émargea des tréfonds nébuleux de l\'antiquité, s\'identifiait progressivement à \"YEMA GOURAYA\" Sainte Patronne, protectrice des lieux et des poètes. Beauté sublime, Bédjaïa ne pouvait échapper du coup à l\'éloge quasi dithyrambique d\'un amant qui de surcroît est un natif du lieu : - \"YA B\'JAIA....\" (O BEDJAIA), ultime appel lancé par Hamid depuis son pays d\'exil, Paris, pour exprimer l\'attachement intérieur à la terre qu\'il a dû quitter, voici maintenant 25 printemps : \"YA B\'JAIA\" est un chant qui le replonge dans son NOSTOS : nostalgie d\'une époque inoubliable. Lorsque sous la houlette de hadj SADDEK, fondateur du cercle Musical Andalous, Hamid affûtait patiemment ses \'cordes\', afin d\'accompagner les chants lancinants des marins pêcheurs, conjurant leur sort précaire... Enfin du peuple la musique \" chaâbi \" lui sied à merveille : elle lui \"colle à la peau\", pour reprendre les propos d\'un intime. Nous avons la conviction, quant à nous, que Hamid reflète le parfait musicien méditerranéen. Il excelle fort bien dans le genre \"chaâbi\", \"Andalous\", \"La qsida (qaca\'id )\", \"le Hawzi\" etc., sans omettre bien sûr les textes qu\'il écrit et chante dans la langue de SI MOHAND (poète - barde Kabyle du XXe siècle débutant).... Enfin, à l\'instar de Dahmane ELHARRACHI, son ami de cour, à qui il rendit un hommage très prononcé dans un texte d\'une rare sensibilité, Hamid a su surmonter la tragédie de l\'exil grâce à un travail assidu de création musicale et poétique. Sources : Ouali CHEKOUR', 4, 'img_artistes/hamid abdjaoui.jpg', 1, 33, 152, '2023-12-03 05:40:41'),
(34, 'Hassen elkaoune', 'À compléter', 4, 'img_artistes/hassen elkaoune.png', 1, 29, 150, '2023-12-03 05:40:41'),
(35, 'Hassen said', '(né en 1931) (décédé le 7 octobre 2013)- Interprète de Chaâbi. Né à Tlemces dans le quartier \"d\'Agadir\'\' au sein d\'une famille de mélomanes. Dès l\'âge de huit ans, il fait partie de l\'Association musicale El-Gharnatia à la Casbah d\'Alger. Elève de Hadj M\'hamed El Anka avec Amar Lachab dans les années 50. Pour des raisons familiales il quitte l\'école pour travailler au port. C\'est là qu\'il rencontra cheikh Hadj Lahlou qui l\'encouragea et lui remit de nombreuses qaca\'id avant de passer à la radio et d\'enregistrer chez Teppaz, Pathé-Marconi et Philips. Ses premiers succès furent des chansonnettes dans le genre Li \'aâtah rabi (de Habib Hachelaf) et Sift Achamâa. Il travaille beaucoup avec Mahboub Bati qui lui composa plusieurs chansons dont la fameuse Ahwa Ahwa \'ale Ayyami rahat Khssara.', 4, 'img_artistes/hassen said.jpg', 1, 30, 150, '2023-12-03 05:40:41'),
(36, 'Kamel belkhiret', 'À compléter', 4, 'img_artistes/kamel belkhiret.png', 1, 37, 150, '2023-12-03 05:40:41'),
(37, 'Kamel bourdib', 'Interprète de chaâbi. Né à Alger, révélé au grand public en 1983, dans le style madih dini (chant religieux), Kamel Bourdib a su garder cette stature qui fait de lui un cheikh.', 4, 'img_artistes/kamel bourdib.jpg', 1, 37, 150, '2023-12-03 05:40:41'),
(38, 'Kamel messaoudi', '(né en 1961) Décès : 10 décembre 1998 (à 37 ans) - Interprète de chaâbi. Né le 30 janvier 1961 à Bouzaréah, sur les hauteurs d\'Alger, il a grandi dans un quartier populeux de la peripherie de la même cite, au sein d\'une famille modeste, entassée dans un appartement exigu niché au douzieme étage. Au départ, respectant la trilogie des demunis (s\'en sortir par le sport, le spectacle ou le trabendo), il est attire par le football. Son père s\'y oppose et suite à de très bons resultats scolaires préfère l\'encourager a aller loin dans ses etudes. Kamel suit le chemin du frère ainé qui s\'adonnait à la musique et choisit la voie artistique. Ses débuts, il les effectue en 1974, lorsque membre de l\'unja, il monte un groupe chaâbi. Sa voix posée et pathetique le fera vite remarquer, d\'abord par les gars du quartier, ses premiers admirateurs. A la tête d\'une nouvelle formation, il anime en 1978, fêtes de mariages et de circoncision et son nom circule avec de plus en plus d\'insistance. Il lui faudra toutefois attendre 1985 pour tenter un essai discographique qui ne sortira jamais car le producteur décréta la mort du chaabi face à la déferlante raï. Commercialisé sous forme de cassette en 1990, il n\'obtient aucun succès. Deux enregistrements suivront, mais la reconnaissance tarde à venir. En 1991, coup de tonnerre dans un ciel endeuille par la violence ambiante: une cassette émerge: Echemaâ (La bougie), récitée avec conviction sur le mode sika sbania (flamenco), est un succès dans lequel toute une jeunesse se reconnait. Subissant l\'influence à la fois de Cheikh el Hasnaoui et de Dahmane el Harrachi, Kamel Messaoudi commet Ah Ya Dzaîr, un vrai manifeste ou le chaâbi renoue avec la réalité sans perdre de sa poèsie. Très exigeant envers lui-même, il choisit méticuleusement ses sujets. II préfère des chansons à thèmes et des paroles de choc qui laissent des empreintes. Appréciant aussi bien Ezzahi que Georges Michael ou Magda Roumi, il est conscient que c\'est grâce aux jeunes de sa génération tels Meskoud et Doumaz que le renouveau du chaâbi devient possible.', 4, 'img_artistes/kamel messaoudi.jpg', 1, 30, 150, '2023-12-03 05:40:41'),
(39, 'Kateb naguib', 'À compléter', 4, 'img_artistes/kateb naguib.jpg', 4, 28, 150, '2023-12-03 05:40:41'),
(40, 'La corale', 'À compléter', 4, 'img_artistes/la corale.jpg', 4, 28, 150, '2023-12-03 05:40:41'),
(41, 'Lili labassi', 'À compléter', 4, 'img_artistes/lili labassi.jpg', 1, 28, 150, '2023-12-03 05:40:42'),
(42, 'Line monty', 'Line Monty (née à Alger - décédée en 2003 à Paris) est une chanteuse française d\'origine juive . On lui doit des standards comme Ana loulya, Ektebli chouiya, Ana Ene Hobbek, Berkana Menkoum, Khadahtini (Tu m\'as Trahi), Alger, Alger, Laissez moi vivre, Ma Guitare, mon Pays, ou en encore Ya oummi. Le répertoire de Line comprend des styles variés comme le chaâbi, ou des rumbas franc arabes très populaires. L\'Orientale est une chanson rendue célèbre par Line Monty. Née dans une famille de mélomanes algérois, qui appréciait autant le registre traditionnel algérien que la mélodie occidentale, elle est donc tout aussi attirée par la chanson réaliste française (Damia, Marjane, Édith Piaf) que par les mélodies orientales d\'Oum Kalsoum ou Mohammed Abdel Wahab. Après des cours de chant et de diction, elle se lance, et récolte rapidement une moisson de succès. Avec sa diction impeccable et sa chaude voix (pimentée de mélismes qui révèlent aux amateurs une ascendance méditerranéenne), elle renouvelle le genre réaliste dans la lignée de chanteuses comme Damia ou Marjane. Elle obtient le prix Edith Piaf, puis le premier prix de l\'Olympia, accumule les tubes dans les music-hall et dans les cabarets des quartiers chics. Elle défend ainsi les couleurs de la chanson française dans le monde entier, Canada, États-Unis (à New York, elle tiendra un club en vogue pendant une dizaine d\'années), Amérique Latine, Allemagne, Hollande et Moyen-Orient. Au pays des pyramides, elle fait sensation : son ami Farid El Atrache lui fait répéter une de ses compositions et les Égyptiens, ignorant qu\'elle possède aussi cette culture, se bousculent pour aller écouter « la Française qui chante si bien l\'arabe ». Oum Kalsoum et Mohammed Abdel Wahab se déplacent... Sa carrière bascule lorsqu\'un ami lui propose « L\'orientale » (composée par Youssef Hagège), un morceau « francarabe » et, séduite par ses nuances, elle l\'enregistre et en fait un titre populaire, souvent repris par d\'autres artistes. Ses admirateurs lui réclament de plus en plus de chansons traditionnelles algériennes et elle met un point d\'honneur à aligner d\'autres couplets à succès : « Ektebli Chouïa » (Ecris-moi de temps en temps), « Ana Louwlia » (Je suis la femme simple)... Line Monty va réduire son répertoire français et alterner les chansons du patrimoine algérien avec de nouvelles compositions écrites sur mesure pour elle. Sa beauté et sa présence étonnante, acquise à l\'école du cabaret (le public présent lors d\'une de ses rares apparitions - c\'était à l\'occasion du Festival de la danse de Montpellier, en a gardé un souvenir ému), ajoutent à ce folklore une touche hollywoodienne pour soigner les langueurs d\'un auditoire plongé dans la nostalgie et l\'exil... Il est à noter que Line Monty joua son propre rôle dans le Grand Pardon 2, d\'Alexandre Arcady. Après le décès de Line Monty en 2003, et de Lili Boniche en 2008, disparus dans le plus grand silence médiatique, un documentaire historique sur les trésors de la musique arabo andalouse et de la musique judéo arabe intitulé le port des amours, fut réalisé par Jacqueline Gozland. Line Monty fut une véritable diva, une ambassadrice de charme du répertoire français ou oriental. Diction parfaite, voix grisante, élégance dans le geste et sensualité dans le mouvement : \"elle était toujours en état de grâce, sa voix féline emportait nos cœurs, élevait nos âmes et sa beauté nous laissait sans voix\" a dit d\'elle feu Youssef Hagège qui avec la complicité de Maurice El Medioni, fut l\'un de ses auteurs favoris. Line Monty et Reinette l\'Oranaise sont enterrées au cimetière parisien de Pantin. <>Source: http://fr.wikipedia.org/wiki/Line_Monty<>', 4, 'img_artistes/line_monty.jpg', 1, 28, 150, '2023-12-03 05:40:42'),
(43, 'Luc cherki', 'À compléter', 4, 'img_artistes/luc cherki.jpg', 1, 28, 150, '2023-12-03 05:40:42'),
(44, 'Maazouz bouadjadj', '(né en 1935) - Brillant interprète de chaâbi. Né le l6 janvier 1935 à Mostaganem. Aîné de neuf enfants, fils de M\'hamed, un petit commerçant il fera ses études primaires à l\'école Condorcet avant d\'obtenir, en 1948, son certificat d\'études. A huit ans, il découvre, sur les genoux de son père, les joies qui entouraient les orchestres les soirs de mariages. C\'est de cet âge que datera son goût pour la musique, le chant et son admiration pour les cheikhs de l\'é poque, comme Belkacem Ould Said et Abderrahmane Benaissa, dont il sera plus tard l\'élève. A quatorze ans, il se met à apprendre à Jouer de la flûte que son oncle paternel Mekki, tourneur à Paris chez Renault, fabriquait à partir de tubes de fer. Il rentre, en 1948: comme commis à la pharmacie Viale avec un contrat d\'apprentissage de trois années pour devenir préparateur en pharmacie. Métier qu\'il exercera jusqu\'en 1964, A dix-sept ans, il crée un petit orchestre pour animer les mariages, avec les musiciens Hamou Bensmaïn, Kaïd Benhenda et Bensabeur Belmoulouka, En 1956, il rejoint la grande troupe d\'El Masrah, dirigée par Abdelkader Benaissa, un enseignant. Il y a là, Ould Abderrahmane Kaki, dramaturge et metteur en scène, le chanteur et musicien Mohamed Tahar et le comique Ahmed Benaceur. Héritier d\'une tradition inaugurée par le Cercle du Croissant et l\'Association culturelle Es- Syidia, et ce depuis plusieurs décennies, cette troupe se produisait à travers tout le pays, notamment lors des saisons artistiques des opéras d\'Oran et d\'Alger. Offrant des spectacles de musique et de théâtre, elle avait aussi parfois comme têtes d\'affiche cheikh Hamada et cheikha Remiti. En 1961, Bouadjadj est arrété pour ses activités militantes au sein du FLN et interné dans les camps de Aïn Tedelès et Sidi Ali, dans la région de Mostaganem. A l\'indépendance, il fonde son orchestre chaâbi avec Abdelkader et Belyajin Belahouel, Djilali Benkaabouche et Medjoub Benkheira. En 1964, il fait une tournée en Europe avec la troupe de Ould Abderrahmane Kaki pour lequel il compose les musiques de théâtre et Afrique. A seize ans, l\'adolescent Bouadjadj chantera sa première Qacida, celle d\'El Achiqa du cheikh El Mekki El Fassi que lui confiera, pour le mettre à l\'épreuve, le Cheikh Abderrahmane relaissa. Ce dernier qui vivait dans le quartier populaire de Tidjitt, interprète de chaâbi, de hawzi et de m\'gharbi, était souvent sollicité, pour des textes, par les cheikhs El-Anka, Hadj M\'Rizek et Hadj Ménouer. Bouadjadj, qui a vécu également à Tidjitt au quartier de la Carrière, fréquentait aussi les cheikhs Menouer Ould Yekhlef, un ami de Hamada, Ali Benkoula, Tidjini Berrezam et le cheikh Lazoughli qui fut également musicien du cheikh Belkacem Ould Said. Une grande rencontre va marquer sa vie et son art. Celle avec le cheikh Hamada qu\'il fréquentera assidûment à partir de l 964. Attentif, perspicace, encourageant, Hamada lui corrigera et lui expliquera le sens parfois caché d\'un mot, d\'un vers, d\'une qasida. L\'interprète qui a dans son répertoire près de 250 chansons enregistrera son premier disque en 1974, un 33 tours, avec deux superbes textes Aïd El-Kebir de Bentriki et Ya Saki du cheikh Ben slimane et trois cassettes. Admirateur de Hadj M\'hamed El Anka, Hadj Menouer, H\'Sissen et Khelifa Belkacem, Bouadjadj fait partie de la génération des Amar Lachab, Boudjemaa El-Ankis, Hassen Said, l\'Mimi, Garami, Rachid Douki et Guerrouabi. Il a su élaborer son propre style, sa propre fàçon de faire qui consacre, avec ses succès, son travail, son art. Il se distingue ainsi avec des titres comme El Meknassia et Taoussoul de hadj Kaddour EI-Alami, Madoumch El Hakma Li makrache Hrouf El Bali de cheikh Benali Ould R\'Zine, Narak ya Welfi de Ghanem El-Fassi. Joueur invétéré de mendole, amateur de lecture, de musique classique et d\'andalou (Dahmane Benachour et cheikh Belhocine), il s\'applique à élaborer des compositions musicales qui mettent en valeur la richesse, les subtilités, les finesses des poèmes. Ce préparateur en pharmacie, doté d \'une mémoire prodigieuse, respecte authenticité, l\'originalité qui fait la force d\'un texte. ouadjadj se défie de toute \"modernisation\" de ce genre. A partir de 1971, animateur culturel à la SN Sempac. Il s\'installe à partir de 1976 à Oran, le futur quartier général du rai.', 4, 'img_artistes/maazouz bouadjadj.jpg', 1, 28, 150, '2023-12-03 05:40:42'),
(46, 'Mhamed yacine', 'À compléter', 4, 'img_artistes/mhamed yacine.png', 1, 30, 150, '2023-12-03 05:40:42'),
(47, 'Mohamed elbadji', '(né en 1933) - Interprète de Chaâbi et auteur- compositeur. Plus connu sous le sobriquet de\"Khouya EI Baz\", Mohamed El Badji dont les oncles sont de Béni Ouartilène et les parents d\'El-Eulma est né le 13 mai 1933 à Belcourt (Alger). Il a écrit et composé des chansons que d\'autres chanteront : Amar Zahi, Aziouz Raïs, Reda Doumaz et des dizaines d\'autres. Son emprisonnement à Serkadji durant la guerre de Maqnin Ezzine. Ayant une voix rocailleuse et profonde, son chant reste une quête permanente d\'échapper à la douleur. Son attachement à la musique remonte à l947, période où tout jeune il fréquentait le cercle scout d\'El Mouradia Foudj El Amanaux côtés de Didouche Mourad et ce jusqu\'en 1952. Il figure dans la troupe de Kaddour Abderrahmane, dit Kanoun. Ses camarades de classe étaient cheikh Bâaziz, Chaâbane Madani, Brahim Siket. A partir de 1952, il participe épisodiquement à des fêtes populaires dans différents orchestres. Arrêté pendant la grève des Huit Jours, en l957, i1 est torturé, jugé et condamné à mort, son exécution n\'aura pas lieu. Dans sa cellule, il fabrique une \"guitare\" de fortune d\'où sortira la musique de Ya Maqnine Ezzine (L\'oiseau révolutionnaire). Au mois de mars 1962, il retrouve la liberté et se remet à la besogne. De 1963 à 1977, il occupe un modeste emploi au ministère de la Justice avant son départ pour la retraite. Depuis, il s\'occupe de sa boucherie située dans le marché \"Gaspar\" à El- Mouradia. Mais ses grands moments, il les consacre au chaâbi. Il écrit et compose Bahr Attoffane.', 4, 'img_artistes/mohamed_elbadji_1.jpg', 1, 40, 150, '2023-12-03 05:40:42'),
(48, 'Mohamed marocaine', 'Hamadi Benmohamed Cherkaoui, plus connu sous le nom de Cheikh Marocain, est né à La Casbah d\'Alger le 27 avril 1907. Gardien de but Du Mouloudia Club Algérois Pendant Presque Une décennie De 1928 À 1935 Bien Qu\'il est Joué Un match amical Avec Le Mouloudia à. Mascara le 23 septembre 1927 (début de La Saison 1927-1928) Mais Il Signa Au Vga (vit au Grand Air) Avant D\'opter Pour Le Mouloudia La Saison D\'après 1928-1929.\r\n\r\nHabitant à La Rue Marche N°12 à Belcourt Pendant L\'époque Coloniale, c\'est Là Où Il Débuta Sa Carrière De Chanteur En 1931 Dans La Chansonnette, Le Plus Souvent D\'inspiration Marocaine D\'où Son Nom Artistique Cheikh Marocain, Il Sera D\'ailleurs Connu Par Son Interprétation De La Fameuse Chanson \"rachda\", Reprise Par Plusieurs Auteurs Et Chanteurs Après Lui Et Qui Reste L\'une Des Chefs-d’œuvres Du Cheikh Marocain. Les cafés étaient ses lieux de prédilection pour se produire et se faire connaître auprès des mélomanes. L\'un était situé près de la Mosquée Ketchaoua et l\'autre à Belcourt (belouizdad actuellement). \r\n\r\nDoté d\'une grande dextérité et d\'une prudence remarquables, ce gardien de but a vécu les moments historiques du démarrage du Mouloudia de 1928 à 1935. \r\n\r\nConcurent Du Gardien De But Bouktache Hmida Durant Ses Premiers Pas En Équipe Fanion Du Mouloudia En 1928, Il Arrive A Devenir Titulaire À Part Entière, Malgré Sa Taille Moyenne , À Force De Travail, De Sérieux Et D\'abnégation Au Point De Devenir Champion D\'alger De La Seconde Division Et Réussir L\'accession En Première Division Avec Le Mca En 1930-1931. En 1935, il décide de quitter le Mouloudia pour laisser sa place au Grand Branki Boualem, en ratant de peu de participer à l\'historique accession du club parmi l\'élite en 1936. \r\n\r\nD\'après les informations qui nous sont parvenues, il semblerait qu\'il ait quitté Alger pour s\'installer à Douéra avant sa mort. \r\n\r\nLe 8 février 1973, Cheikh Marocain a rendu son dernier souffle à Alger, à l\'âge de 66 ans.', 4, 'img_artistes/marocain.png', 1, 160, 151, '2023-12-03 05:40:42'),
(49, 'Mourad djaafri', '(Né en 1963). Interprète de chaâbi. Pour ce technicien en architecture, natif d’Alger, sa passion pour le chaâbi se manifesta un soir de l’année 1974 en écoutant El barah interprétée par El Hachemi Guerouabi. En 1978, il chanta sa première chanson en public Ya Ibn Ouarchane. Adhérent des SMA, il apprend à vivre et à chanter en groupe. Durant cinq ans, jusqu’en 1988, il ne fait que les fêtes familiales. Il rejoint par la suite l’association Essoundoussia en vue de parfaire sa Sanaâ tout en s’essayant à l’écriture. Deux cassettes, deux succès : Ya Baba el Ghali, un hommage au père décédé en 1982 et Oudaâ (1995).', 4, 'img_artistes/mourad djaafri.jpg', 1, 33, 150, '2023-12-03 05:40:42'),
(50, 'Msamae', 'À compléter', 4, 'img_artistes/msamae.jpg', 1, 32, 150, '2023-12-03 05:40:42'),
(51, 'Mustapha belahcen', 'À compléter', 4, 'img_artistes/mustapha belahcen.png', 1, 32, 151, '2023-12-03 05:40:42'),
(52, 'Mustapha boutchiche', 'À compléter', 4, 'img_artistes/mustapha boutchiche.png', 1, 30, 150, '2023-12-03 05:40:42'),
(53, 'Mustapha elhabassi', 'À compléter', 4, 'img_artistes/mostafa-abbassi.png', 1, 158, 150, '2023-12-03 05:40:42'),
(54, 'Mahfoud', 'A crée le site Chaabi Dialna La musique Algérienne (webchaabi.com). Articles sur les chanteurs Algériens, leurs interviews, Chansons et poèmes traduit [Qacidattes). Animateur Radio depuis 1979 en France (Paris)...', 4, 'img_artistes/mahfoud-0l.jpg', 1, 137, 162, '2023-12-03 05:40:43'),
(55, 'Nadia benyoucef', 'Née en 1958 à Bad Djedid, à la Casbah d\'Alger. Brillante interpréte, serait originaire des environs de Cherchell, élève à El-Mossilia, mais abandonne ses études musicales. El-hane oua Chabab, l\'émission de television consacrée aux jeunes talents, la révèle au public en 1973, alors qu\'elle n\'avait que 15 ans. Par le timbre chaud et fin de sa voix, elle introduit une note de fraîcheur dans l\'interprétation du hawzi. Leytim lui servira de prélude avant le grand succès de Ya l\'Mima, chanson qui lui a été spécialement composée par Rabah Driassa. Sa collaboration avec deux compositeurs confirmés, Mâati Bachir et Tahar Benhamed, ne lui apporte que des satisfactions : Yal Warda et El Khatem. Ses duos avec Chaou (El Waldine et Kahwa ou Latey) et Kouffi (Yassadni et Lazem Tedbir) ne passeront pas inaperçus. Toutefois, la presque totalité de sa carrière reste marquée par deux personnalités : Mâati Bachir pour la composition (Aâmrat Dari, Lqit Lghzel, El Mouhami, etc.), et Saloua pour les conseils, elle quitte l\'enseignement pour se consacrer à la musique et à son foyer. Questionnée sur ce qu\'elle pense des partis politiques (en 1990), elle a répondu Mon parti à moi, c\'est mon public et ma politique c\'est la musique. Au mois de juin 1994, elle annonça brusquement son retrait définitif de la scene artistique, allant jusqu\'à demander à la radio et à la télévision de cesser la diffusion de ses chansons. Elle insistera sur le fait que les raisons de son retrait sont \"volontaires et personnelles\". Toutefois, elle reprendra le chant de manière discrète et s\'installa à Marseille (1996).', 4, 'img_artistes/nadia benyoucef.jpg', 1, 46, 150, '2023-12-03 05:40:43'),
(56, 'Nadia dziria', 'À compléter', 4, 'img_artistes/nadia dziria.jpg', 1, 48, 150, '2023-12-03 05:40:43'),
(57, 'Nadia staifia', 'À compléter', 4, 'img_artistes/nadia staifia.jpg', 1, 35, 150, '2023-12-03 05:40:43'),
(58, 'Nadia yasmine', 'À compléter', 4, 'img_artistes/nadia yasmine.jpg', 1, 31, 150, '2023-12-03 05:40:43'),
(59, 'Nafia chaffa', 'Née en 1958 à S-t Eugène (Alger) Décédée le 16 décembre 2017 (Paris) Interprète Chaabi et Hawzi. Autodidacte aux chant Chaabi et Hawzi et au piano à l\'age de 12 ans avec les orchestres féminines comme pianiste grâce à l\'amour du Chaabi, et au travail considérable à la maison sur le piano familiale à Alger (avec Aouichatte, Saloua, Nadia Benyoucef), ensuite à commencée a chanter à l\'age de 20 ans avec son propre orchestre, Fille de Mohamed CHAFFA luthier artisant d\'instruments musicales (Bondjo, Mandole). Sa première kassette (EL HANNA) en duo avec Aziouz Rais en 1990. Deuxième kassette en 1991 chez ELANKAOUIA, après quoi, elle migra en France ou elle peut faire des soirées et des mariages jusqu\'à ce jour (2009) Comme musicienne avec Kamel Messaoudi, Chaou Abdelkader, Guerouabi, Sid Ali Lekkam, et d\'autres...', 4, 'img_artistes/nafia chaffa.jpg', 1, 31, 150, '2023-12-03 05:40:44'),
(60, 'Naima', 'À compléter', 4, 'img_artistes/naima.png', 1, 30, 150, '2023-12-03 05:40:44'),
(61, 'Nardjes', 'Interprète du Chaâbi. Jusqu\'en 1991, elle n\'enregistra aucune cassette et se contenta d\'enregistrer uniquement pour la radio ou la télévision. L\'épouse du chanteur Youcef Boukhentache pense qu\'elle a été victime d\'une marginalisation excessive.', 4, 'img_artistes/nardjes.jpeg', 1, 36, 151, '2023-12-03 05:40:44'),
(62, 'Nouri kouffi', '(né en 1954). Interprète de Hawzi et de Aroubi. Né le 31 décembre 1954 à Tlemcen. A huit ans, s\'intégra très vite dans les meilleures associations musicales de la ville, sous la houlette des maîtres de l\'école classique, tels que Hasseïn, Aboura et Benali. A des qualités vocales et une inspiration exceptionnelle, le jeune interprète ajoute encore ses propres recherches pour la maîtrise de plusieurs instruments: luth, mandoline, violon et Rbab. Dès 1974, il passe les examens d\'admission au corps enseignant en qualité d\'instituteur. II est recruté par l\'education nationale et deviendra par la suite professeur titulaire. Parallèlement, il crée une chorale et un orchestre d\'élèves. Vice-président de l\'Association des auteurs - compositeurs, interprètes et musiciens (IPPO) Enregistre son Sidi Boumédiène en 1981-1982 dans l\'émission de télévision Rasd ma Maya animée par Leïla. Le texte de ce \"succès\" lui a été remis par Chérifa Bent Essadek. Son premier disque, un 33 t. sort en 1977. D\'autres enregistrements suivront.', 4, 'img_artistes/nouri kouffi.jpg', 1, 30, 150, '2023-12-03 05:40:44'),
(63, 'Rabah driassa', 'Rabah Driassa (en arabe : رابح درياسة) est un artiste peintre et auteur-compositeur-interprète algérien né le 19 août 1934 à Blida et mort le 8 octobre 2021 dans la même ville1.\r\n\r\nOutre ses propres compositions, il chante aussi de la musique populaire et du bedoui sahraoui algériens. Il est connu depuis les années 1960 jusqu\'aux 1980 avec de nombreuses chansons du terroir qui restent des chefs-d\'œuvre dans le domaine, telles que Yahya wlad bladi, Hizia, Mabrouk 3lina, El Goumri, El Aouama et tant d\'autres qui ont marqué la musique algérienne et maghrebine de cette époque.', 4, 'img_artistes/rabah driassa.jpg', 1, 47, 151, '2023-12-03 05:40:44'),
(64, 'Rachid koceila', 'À compléter', 4, 'img_artistes/rachid koceila.png', 1, 38, 52, '2025-01-13 13:31:25'),
(65, 'Radia adda', '(née en 1970) - Interprète de Hawzi. De son vrai nom Safia Adda, Radia est née le 18 Août 1970 à Belouizdad (ex-Belcourt, Alger). Abandonne ses études en dernière année du fondamental pour se lancer sur les traces de Fadela Dziria, son idole. Après El-Fakhardjia, elle rejoint l\'association Es-sendoussia où elle y passe six ans. Mais noyée parmi quarante élèves, elle ne pouvait évoluer, et donc, se révéler, c\'est pourquoi elle décide d\'enregistrer sa première K7 dans le hawzi, en 1993, aux éditiens Chabab. Trois autres suivront dont une avec Karima. Sensible au Chaâbi de Guerouabi et Ezzahi.', 4, 'img_artistes/radia adda.jpg', 1, 31, 150, '2023-12-03 05:40:44'),
(66, 'Reda doumaz', 'Interprète de Chaâbi Son itinéraire artistique de chanteur chaâbi est des plus classique. Né en l956, il grandit au sein d\'une famille de mélomanes, dans un quartier populaire où les fêtes sont omniprésentes. Cependant, il ne se voue pas entièrement à sa passion parce qu\'il choisit de terminer ses études. C\'est ainsi qu\'il devient cadre supérieur dans une entreprise nationale. La radio contribue à le faire connaître dès l985, et trois enregistrements lui ont valu la reconnaissance du public. Pour Reda Doumaz, toutes les musiques et les influences peuvent subir une relecture \"chaâbi\", notamment le jazz, pour insuffler un zeste de modernité et un goût de liberté sans s\'éloigner pour autant de l\'esprit. Amoureux de poésie symbolique, il n\'aime pas imposer une idée toute faite au public, afin que celui-ci découvre sa propre lecture. Reda Douma utilise le chant comme forme d\'expression. l\'amour impossible, la jeunesse, les quartiers populaires, son pays... les thèmes sont de tous les temps et constituent un patrimoine commun aux artistes. Le chanteur chaâbi perçoit son impact directement au sein des familles et il est donc en contact permanent avec la société. Reda Doumaz exprime la quête de son travail artistique de la façon suivante : \'Ma mission est de dire l\'identité culturelle de mon pays avec le souffle d\'aujourd\'hui\'..', 4, 'img_artistes/reda doumaz.jpg', 1, 31, 150, '2023-12-03 05:40:44'),
(67, 'Reinette loranaise', '(née en 1915).- Dame de la musique classique algérienne. Reinette Sultana Daoud est née à Tiaret. Son père est un rabbin d\'origine marocaine et dans sa famille, qui a reçu la citoyenneté française accordée aux Juifs algériens par le décret Crémieux (1870), on parle arabe depuis des lustres. A l\'âge de deux ans, une variole mal guérie la laisse aveugle. A l\'école des aveugles d\'Alger, elle apprend le braille et... le cannage des chaises, mais sa mère n\'a pas toléré qu\'elle continue à faire ce travail qui lui abîmait les doigts, elle a voulu pour elle plus de gaîté et a demandé à Saoud l\'Oranais de l\'initier à la musique arabo- andalouse. Du haut de ses treize ans, Reinette passe donc sa première audition. L\'essai est concluant puisque le maître décrète \"qu\'on pourra en faire quelque chose\" et la prend en pension chez lui. Il en sort quelque temps plus tard un 78 tours, que plus tard Reinette ose à peine écouter \"à cause des fautes de diction\". Intégrée très vite à l\'orchestre du maestro, elle en profite pour mémoriser les musiques et les paroles de centaines de chants. C\'est aussi dans le Darb, vieux quartier juif d\'Oran, qu\'elle se familiarise avec les instruments de musique. Après la darbouka, elle s\'initie à la mandoline puis au oud (luth arabe) qu\'elle affectionne particulièrement. En 1938, le maître Saoud Médioni émigre en France pour monter un café musical à Paris. Reinette, qui l\'adorait sans le lui avoir jamais montré le rejoint dare-dare, mais elle est gentiment éconduite avec ces belles paroles\'. \"Mademoiselle, vous avez plus besoin de moi\". Ce seront les derniers mots qu\'elle entendra du maître vénéré qui mourra peu de temps après en déportation. Dans les années 40, Reinette quitte son Oranie natale pour Alger où à l\'âge de 26 ans elle débute une carrière passionnante. Elle anime à radio Alger deux soirées hebdomadaires et devient assez vite la chanteuse incontournable des fastueuses soirées altérasses. Accompagnée des meilleurs musiciens comme Mustapha Skandrani (piano), Alilou (darbouka), Abdelghani (violon) elle chante avec les plus grandes voix de la chanson populaire et classique du Maghreb : Fadela dziria, Meriem Fekkaï, Alice Fitoussi, Zohra El-Fassia, Abdelkrim Dali, Dahmane Benachour. Elle a même accompagné le maître du Chaâbi, Hadj M\'Hamed El-Anka. Reinette exerce son art dans les nombreuses fêtes juives et musulmanes, mariages, circoncisions, anniversaires. Comme séfarade elle a même été admise à chanter dans un orchestre d \'hommes. Son nouveau maître de chant Abderrahmane Belhocine lui donne des cours d\'arabe littéraire et lui fait travailler sa diction sans relâche. Et puis le temps passe et avec lui les belles années faites de succès et de Cites. Durant la Guerre de Libération nationale, elle quitte, la mort dans l\'âme, sa terre natale et sa chaleur pour se replier dans la grisaille parisienne. Commence alors une longue période de repli médiatique et de solitude. En 1985, Reinette a 70 ans et ne songe plus qu\'a cultiver ses souvenirs. Il faut toute la ténacité d\'un animateur de Radio-Beur à Paris pour la convaincre de remonter sur scène. Vit (en 1995) en banlieue parisienne, aux côtés de son mari, Georges Layani, un percussionniste.', 4, 'img_artistes/reinette loranaise.jpg', 1, 29, 150, '2023-12-03 05:40:44'),
(68, 'Rene perez', 'À compléter', 4, 'img_artistes/rene perez.png', 1, 29, 150, '2023-12-03 05:40:44'),
(69, 'Rym', 'RYM HAKIKI, star de la jeunesse algérienne, nouvelle princesse de la musique arabo-andalouse et du hawzi. A 8ans elle rejoint l’école musicale NASSIM AL ANDALOUS d’ORAN.\r\nChanson populaire, musique andalouse et hawzi, c’est avec un répertoire étendu qu’elle sort dés l’âge 16 ans son premier album YA OULD EL NASS ainsi que MAL HBIBI MALOU et KHAYEF LA CHEMISSA, Ces succès qui ont fait renaître la musique algérienne et ont démontré les talents d’un artiste prodigieux.\r\nDésormais, connue et reconnue par son charisme et son talent de vocaliste, elle enchaîne l’enregistrement de dix albums. le plus célèbre et sans doute l’album de la consécration, « SABRA » vendu à plus d’un million d’exemplaires. Aujourd’hui, surnommée la nouvelle merveille de la chanson andalouse, RYM HAKIKI est la pionnière d’un nouvel air musical et d’un valeureux héritage traditionnel, avec sa voix dégageant chaleur et douceur à la fois, elle incarne la culture algérienne à travers le monde, et de son souffle contemporain, attise passionnément les braises de la tradition.', 4, 'img_artistes/rym.jpg', 1, 35, 150, '2023-12-03 05:40:44'),
(70, 'Samir Toumi & Radia Manal', 'À compléter', 4, 'img_artistes/samir toumi & radia manal.jpg', 1, 31, 150, '2023-12-03 05:40:44'),
(71, 'Samir toumi', 'SAMIR TOUMI, chanteur algérien, voit le jour le 12 janvier 1972 à Alger (Algérie).\r\n\r\nIngénieur agronome de formation, Samir a derrière lui tout un parcours dans la musique andalouse et Haouzi. Il fait partie, depuis 1979, de l\'association El-Djazairia El-Mossilia où il apprend à jouer de la mandoline et du violon avant de créer une association à savoir Thäalbiya en 1990.\r\n\r\nSamir accompagne les deux troupes lors de galas, soirées et tournées à travers les pays du Maghreb, voire du vieux continent.\r\n\r\nEntre 1992 et 1993, il crée sa propre troupe ensemble avec des musiciens chevronnés. De festivals en festivals, de manifestations en manifestations, Toumi et sa troupe se font un large public et partagent également des fêtes familiales.\r\n\r\nOutre un Hawzi de haut niveau, Samir interprète tous les genres musicaux du patrimoine algérien et maghrébin. A travers ses 11 albums, Samir Toumi rend hommage au Hawzi et à l\'andalous ainsi qu\'au constantinois et Oranais algérois.\r\n\r\nSamir Toumi ambitionne d\'apporter au Hawzi la touche qui le fera durer et s\'ouvrir à d\'autres styles.', 4, 'img_artistes/samir toumi.jpg', 1, 31, 150, '2023-12-03 05:40:44'),
(72, 'Sidali lekkam', 'Sid Ali Lekkam, né le 7 avril 1961 à Birkhadem (Alger), est un chanteur et interprète de chaâbi.\r\n\r\nLekkam interprète les qacidates (poèmes) des chioukhs (les maîtres du chaâbi) ainsi que de la poésie populaire.\r\n\r\nC\'est en écoutant les maîtres du genre, El Hachemi Guerouabi et Amar Lachab qu\'il vient au chaâbi, en 1974, accompagné par son frère Mohamed.\r\n\r\nSa première cassette a été enregistrée en 1988. Sid Ali Lekkam choisit le plus souvent des textes imprégnés de sagesse que lui écrivent Mohamed Kacemi et Chérif Rahmani. Il est l\'auteur de titres très connus en Algérie, tel que: Ya lati beayoub ennas, nebki w nouwah, ou encore elkhssouma', 4, 'img_artistes/sidali lekkam.jpg', 1, 42, 150, '2023-12-03 05:40:45'),
(73, 'Tahar fergani', 'Mohamed Tahar Fergani naît dans une famille de musiciens. Son père, Cheikh Hamou Fergani (1884–1972) était un chanteur et compositeur algérien réputé de Houzi, un style populaire en provenance de Tlemcen. Il est d\'abord formé à la flûte (de roseau, appelée fhel ou djouwak) lorsqu\'il a six ans et ensuite tous les instruments andalous et par son frère Abdelkrim au métier de la broderie.\r\n\r\nMohamed Tahar Fergani débute dans le genre oriental, du genre charqi en provenance d\'Égypte dans un ensemble Toulou\' el Fadjr (l\'aurore). Puis il change par la suite de style musical pour se rapprocher du Malouf, propre à Constantine et à l\'instigation de son maître Cheikh Hassouna, mais également de Cheîkh Baba Abid et que son père lui avait déjà enseigné les bases.\r\n\r\nMaître de malouf qui est le répertoire de la musique arabo-andalouse de l\'école de Constantine, Mohamed Tahar Fergani est l\'un des rares chanteurs à interpréter des compositions sur quatre octaves. Ce qui caractérise Mohamed Tahar Fergani, c\'est « sa voix chaude et puissante, fortement imprégnée de couleurs orientales qui l\'a rendu célèbre très rapidement » et son coup d\'archet.\r\n\r\nEn plus du Malouf, il interprète le mahjouz (genre populaire constantinois qui dérive du Malouf), Zjoul (genre musical constantinois, aussi ancien que le Malouf) et le hawzi (genre populaire qui dérive du Gharnati de Tlemcen).\r\n\r\nToute la famille Fergani est initiée au Malouf. Sa sœur Zhor Fergani (1915–1982) était aussi chanteuse et son fils ainé, Salim Fergani, est un artiste de malouf et aussi son petit-fils Mouhamed Adlen Fergani qui chante du Malouf aussi.', 4, 'img_artistes/tahar fergani.jpg', 1, 33, 150, '2023-12-03 05:40:45'),
(74, 'Taleb kamel', 'À compléter', 4, 'img_artistes/webc.jpg', 4, 32, 151, '2023-12-03 05:40:45'),
(75, 'Yassine ouabed', 'Yacine Ouabed (né le 27 mars 1967 à Soustara), est un poète et parolier algérien, membre de l\'Onda. Edenia (La Vie) fut son premier poème chanté par le regretté Kamel Messaoudi en 1994, avec la chaleur de sa voix et la beauté de ses paroles Yacine Ouabed a su conquérir les coeurs des fans de la poésie populaire.', 4, 'img_artistes/yassine ouabed.png', 1, 37, 150, '2023-12-03 05:40:45'),
(76, 'Youcef cherchali', 'Youcef Cherchali est un artiste, pur produit de l\'association de musique andalouse Errachidia de Cherchell, formé de surcroît au sein de cette association créée dans les années 70. L\'artiste a pris son envol ensuite. Il avait assimilé les techniques de base de la chanson', 4, 'img_artistes/youcef cherchali.jpg', 1, 32, 150, '2023-12-03 05:40:45'),
(77, 'Abdelkader Chaou & Amar Ezzahi', 'À compléter', 4, 'img_artistes/Amar-Ezzahi-chaou.jpg', 1, 48, 150, '2023-12-03 05:40:45'),
(78, 'Abdellah guettaf', 'Né le 18 août 1949 à Hussein Dey à Alger, feu Abdallah Guettaf a débuté son parcours artistique vers la fin des années 1960 et poursuivi le travail avec professionnalisme et sérieux, jusqu’à son décès le 28 janvier 2011, à l’âge de 61 ans', 4, 'img_artistes/abdellah guettaf.png', 1, 38, 150, '2023-12-03 05:40:45'),
(79, 'Cheikh hsissen', 'H\'sissen, de son vrai nom Ahcène Larbi Benameur, est un auteur-compositeur et interprète algérien de chaâbi né le 8 décembre 1929 au 15 rue Monthabor à la Casbah d\'Alger, et mort le 29 septembre 1959 à Tunis à l\'âge de 29 ans.', 4, 'img_artistes/cheikh hsissen.jpeg', 1, 31, 150, '2023-12-19 16:28:59'),
(80, 'Sidi lakhdar benkhlouf', '(16 ès)-Barde et mystique.\r\nSidi Lakhal b. Abdallah b.Khelouf, prince des bardes du Dahra, plus connu sous le nom de Sidi Lakhdar Benkhelouf, fut un brillant panégyriste du Prophète et l\'un des rares auteurs qui se soient spécialisés dans le madih.\r\nSon renom qui a dépassé les limites du pays des Beni Chougran et de Mascara où il a vécu, est dû à la fécondité de son talent et aux pièces élogieuses qu\'il a composées en l\'honneur du Prophète et à un poème divinatoire du genre malahim.    \r\nAucune date de naissance ou de décès n\'est précisée à son sujet par les auteurs de recueils de poésie.\r\nLe Prophète lui aurait dit en songe de changer son prénom al-Akhal (noir) en Akhdar (vert).\r\nParmi les familles migrantes, celle de Benkhelouf figurait, Lakhdar n\'était à ce moment-là qu\'un enfant qui d\'ailleurs se rappelle très bien les difficultés rencontrées par son père, soulignant plus tard que son aïeul appartenait à la tribu des \"Azafriya\". Abdallah passa toute sa jeunesse à Mazagran (localité située dans la banlieue de Mostaganem) et participa à la bataille qui porte son nom contre les Espagnols et qui a eu lieu le 26 août l558.\r\nDans une qasida célèbre, il relata avec précision les péripéties de cette bataille, Après la cinquantaine, il entreprend un voyage à Tlemcen où il se rendit auprès de cheikh Abou Mohamed Abdelhak Ben Abderrahmane Ben Abdellah El Azdari El Ichbili, plus connu sous le nom de Sidi Boumédiène (594 H - 1216 JC), Après ce contact intellectuellement très fructueux, le poète s\'imprégna du mouvement religieux existant à l\'époque et va de ce fait se consacrer entièrement au culte à la dévotion et à la spiritualité.\r\nAprès son retour de ce voyage, il prend la décision de quitter, en compagnie de sa famille, la ville de Mazagran et la poésie lyrique pour se fixer dans une localité où vécurent ses oncles Ouled Brahim (Ouled Aïn Brahim, située à une vingtaine de kilomètres de Mostaganem). \r\nLà, il s\'affirme en illustre panégyriste du Prophète.\r\nOrphelin de père très jeune, il chérissait de manière particulière sa mère Kella.\r\nIl aurait vécu 125 ans. Malgré la célébrité du poète, la famille Ben Khelouf vivait dans la pauvreté totale. Le barde a été enterré au douar qui porte son nom : Sidi Lakhdar (wilaya de Mostaganem).\r\nTrop pauvre pour entreprendre le pèlerinage, il eut d\'extraordinaires compensations, il aurait vu en rêve, quatre vingt-six-neuf fois, le Prophète Mohamed (), l\'unique objet de son amour ! \r\nQui lui a même accordé une centième faveur : venir le voir, avec ses dix compagnons, \"dans la réalité, et non plus en rêve\" (felyaqda la felmnan). Ainsi qu\'il en avait fait le serment dans le poème de deux cents vers qui commence ainsi : Ya taj El anbya l-kram... Mohamed Bekhoucha rassembla 31 pièces du barde qu\'il publia, en 1985, à Rabat sous le titre Diwan de Sidi Lakhdar Ben Khelouf.', 4, 'img_artistes/benkhlouf.jpg', 1, 42, 150, '2024-02-12 12:21:03'),
(81, 'Djaafar benyoucef', 'Né à Alger (Kouba). \r\nAutodidacte de la musique Chaâbi (quartier, fêtes, mariages). \r\nDepuis sa rencontre avec Sami Eldjazairi, en 1987 à la discotheque \"Triangle\", où il a passe quelques années sympathiques, il n\'arrête pas d\'évoluer dans la musique Algeroise, à travers des fêtes, des galas et mariages.\r\nA son actif six albums, plus le dernier inédit (parole et musique Nacer Fertas, grand paroliers Algerois), sortie prévue en novembre 2001, qui promet de nous faire revivre les grands moments de la musique Algeroise, comme le dernier festival du chaâbi où il a participé aux côtes de : Guerouabi et d\'autres!!! A Paris en 2000. \r\nAnime vos soirees et mariages avec beaucoup d\'ambiances de chez nous... \r\n\r\nSources: chaabi dialna                ', 4, 'img_artistes/djaffarp.gif', 1, 27, 150, '2024-05-25 15:33:20'),
(82, 'Dilem', 'À compléter', 4, 'img_artistes/nac-dilem.jpg', 1, 12, 151, '2024-05-25 15:33:48'),
(83, 'Kamel el harrachi', 'À compléter', 4, 'img_artistes/kamel el harrachi.jpg', 1, 9, 150, '2024-05-29 08:50:57'),
(84, 'Mbs', 'À compléter', 4, 'img_artistes/mbs.gif', 1, 9, 151, '2024-05-29 09:00:38'),
(85, 'Mohamed lamraoui', 'À compléter', 4, 'img_artistes/lamraoui3.jpg', 1, 15, 150, '2024-05-29 09:58:47'),
(86, 'Nacer aya', 'À compléter', 4, 'img_artistes/nacer.jpg', 1, 17, 151, '2024-05-29 10:02:58'),
(87, 'Nacerdine galize', 'À compléter', 4, 'img_artistes/NACEREDINE GALIZ.jpeg', 1, 18, 151, '2024-05-29 10:05:00'),
(88, 'Naima ababsa', 'À compléter', 4, 'img_artistes/naima ababssa.png', 1, 31, 152, '2024-05-29 10:10:18'),
(89, 'Sid ali djiri', 'À compléter', 4, 'img_artistes/dziri.jpg', 1, 24, 1, '2024-05-29 11:31:12'),
(90, 'Sid ali dris', 'À compléter', 4, 'img_artistes/driss.jpg', 1, 21, 150, '2024-05-29 11:33:29'),
(91, 'Zerrouk daghfali', 'Poète, auteur compositeur Genre: melhoun \"chaabi\" né le 5 octobre 1949 à l\'ARBA Marié et père de trois enfants, il effectua son pèlerinage à la Mecque et devint Hadj en 1990. Membre de l\'office national du droit d\'auteur Animations, conférences, débats sur le style Chaâbi débute dans la poésie très jeune, et est à l\'origine de nombreuses œuvres très diversifiées dans les thèmes suivants: - medhe. Hymne au Prophète et à la Mecque - printanière - sociale - sentimentale - sur l\'émigration et d\'autres... Un grand nombre de ses œuvres a été enregistré et repris par les plus grands du Chaabi tels que : CHEIKH ABDELKADER CHERCHAM, ABDELKADER CHAOU, CHEIKH ABDERRAHMANE KOUBI, CHEIKH KAMEL BOURDIB OEUVRES EN COURS: - Trois recueils inédits, le livre sur l\'historique du Chaâbi et de ses Grands Maîtres...', 4, 'img_artistes/daghefali.jpg', 1, 46, 150, '2024-05-29 11:35:41');
INSERT INTO `artistes` (`id`, `nom`, `bio`, `user_id`, `image`, `categorie_id`, `views`, `likes`, `created_at`) VALUES
(92, 'Mustapha nador', '(1874-1926).- Précurseur du genre Chaâbi.\r\nOriginaire d\'Ouled Bellemou à Lakhdaria (Bouira), Mustapha Saïdji, plus connu sous le nom de Mustapha Nador, est né à Bouzaréah le 3 avril 1874. Ses premiers pas dans l\'art musical remontent au début du siécle. Versé dans le mdih religieux, il avait côtoyé les plus célèbres chanteurs de son époque, Selon les historiens de la musique, il serait le premier à avoir introduit en Algérie le chant typiquement maghrébin avant que ce chant n\'évolue et devienne le chaâbi que nous connaissons, Il n\'aimait pas les chants profanes et refusait de faire des enregistrements sur disques. Ayant séjourné pendant trois ans au Maroc durant la Première Guerre mondiale, il en rapporta plusieurs qaca\'id du genre maghrébin qu\'il se mit à adapter, travaillant le style et l\'expression au prix de gros efforts mais aussi d\'une grande passion.\r\nAvant son départ pour le Maroc il était l\'élève de Si Abderrahmane El-Meddah, Cheikh El - Hadra de Sidi Abderrahmane Ethâalibi. Mais déjà sur la scène artistique, on avait outre Cheikh Kouider Bensmaïl qui jouait au def dans un orchestre composé seulement de deux flûtistes, le Cheikh Mustapha Driouche, qui dirigeait un orchestre composé entre autres de Hassen El-Kerraï au violon et de Hadj Abdelkader qui aurait été le premier cithariste algérien. Ayant enrichi son répertoire grâce aux poésies de Mohamed Bensmaïl, père de Cheikh Kouider, il forma dans les années 20, plusieurs orchestres essentiellement composés d\'instruments à corde au rythme du tambourin. A cette époque la darbouka y est exclue et ne fut introduite de manière \"officielle\'\' qu\'à partir de 1926, après la mort de Nador, par son jeune élève M\'Hamed El-Anka. Son \"concurent\" de l\'époque était cheikh Saîd Derres. Il mourut à Cherchell le 19 mai 1926.', 4, 'img_artistes/nador.png', 1, 47, 154, '2024-10-15 10:45:29'),
(93, 'Mariem fekkai', '(1889-1961). - Grande dame de la chanson algérienne.  Originaire de Biskra. Mériem Fekkaï El Biskriya est née à Alger.  Son genre de M\'samaa, typiquement féminin, est inspiré de celui de Mâalema Yamna, laquelle a été son principal modèle, viendra ensuite Cheikha Tetma qu\'elle ne quitta pas d\'une semelle durant une grande partie de sa vie.  Elle a apporté un plus dans la composition de son ensemble artistique, qu\'elle constitua à partir de 1935, en introduisant une forme de prestation musicale et dansée tout à fait nouvelle, car jusque-là les cheikhates ne s\'occupaient pas de la partie ballet traditionnel qui se faisait tantôt d\'une manière spontanée, tantôt sur demande de la famille organisatrice de la cérémonie.      Elle s\'intéressa précisément à ce côté du fait qu\'elle débuta sa carrière en qualité de danseuse à l\'occasion des fêtes familiales, mais également en intermède des spectacles organisés par Mahieddine Bachetarzi, notamment à partir de 1928, période au cours de laquelle il présidait aux destinées de la Société Musicale El Motribiya.  Chanteuse est un métier qu\'elle entreprit très tardivement. Elle a figuré sur un plateau artistique grandiose, le samedi 24 août 1929 à Alger aux côtés de Mahieddine, Sassi et Chabha, une grande chanteuse kabyle de l\'époque. La, elle s\'affirma réellement, comme une artiste complète, car, aux talents de chanteuse, s\'ajoutent ceux de danseuse traditionnelle, agile, élégante d\'une beauté incomparable.  Elle envoûta son public et les organisateurs, car une étoile nouvelle est née, qu\'il fallait compter avec elle. A l\'époque, outre Mériem Fekkaï, Yamna et Tetma, il y avait également Fettouma El Blidiya, Cheikha Zahia, Leila Fatah (L. Mouti) Soltana Daoud (Reinette l\'Oranaise) et Zohra El Fassia.  Pour les Cheikhs genre mdih, qu\'on n\'appelait pas encore Chaâbi, il y avait cheikh Abderrahmane El-Meddah, cheikh Mustapha Driouch, cheikh Mamad Benoubia, Reghaî Abderrahmane dit cheikh Saîdi, cheikh Mahmoud Zaouch, cheikh EI-Hadj M\'hamed El-Anka et son maître cheikh Nador (Mustapha Saîdi) qui était déjà décédé en 1926, pour ne citer que ceux-la.  Pour la musique andalouse, l\'activité était intense également avec la suprématie de la société El-Motribia, la société El-Andaloussia au sein de laquelle figuraient Mohamed Fakhardji, El Djazaîria, El-Ghernata; voyait le jour aussi El Mossilia. Ayant une instruction moyenne, elle compensait cet handicap par sa grandeur d\'âme et son comportement social. Sa maison était le lieu de rencontre de beaucoup d\'artistes.  Aimable et très accueillante, elle fut aidée par son entourage familial et plus particulièrement par son mari, Si Abdelkrim Belsenane, qui ne ménagea aucun effort pour son épanouissement artistique. Ils vécurent une quarantaine d\'années ensemble sans laisser d\'enfant. Mériem Fekkaï choisissait sa clientèle parmi les familles bourgeoises d\'un niveau social élevé; son programme, de ce fait, ne désemplissait jamais durant les étés, en après-midi (dhella) ou en soirée (sahra).  Son programme de chants était compose de poésies du genre Aroubi et Hawzi, des morceaux légers (nqlébète) du classique andalou.  Elle donnait leur chance a toutes les belles voix qui l\'entouraient. Elle avait, pendant une longue période, permis à Fadila Dziria d\'interpréter tous les Istikhbarates, préludes aux chants qu\'elle programmait pour son ensemble a l\'occasion de toutes ses prestations.  Ses succès étaient en grande partie ceux de Yamna ou de Tetma, car puises dans le patrimoine hawzi tlemcénien ou aroubi algérois. Mériem Fekkaï se démarque, malgré tout des autres, par l\'interprétation à l\'unisson de la quasi-totalité des chants. Le Dakhli Msammaî Rana Djinek, chant de bienvenue a la mariée reste son chef-d\'ouvre avec El qelb bete sali et Mene houa Rohi ou Raheti du poète tlemcénien Ibn Msaîeb. Mériem Fekkaï sortait rarement en dehors d\'Alger, sauf pour des visites amicales ou familiales a Tlemcen, ou encore à Miliana pour l\'Aîd El-Adha.  Elle était une cinéphile très avertie. Elle ne ratait jamais son après-midi cinéma et les premières de films qui passaient à Alger. Elle mourut le 18 juillet 1961.', 4, 'img_artistes/fekey.png', 1, 34, 152, '2024-10-15 15:25:05'),
(94, 'Adbellatif merioua', 'né en 1960 - Interprète de Hawzi. Né à Tlemces dans le quartier \"d\'Agadir\'\' au sein d\'une famille de mélomanes. Dès l\'âge de huit ans, il fait partie de l\'Association musicale El-Gharnatia. Il apprend à jouer de la mandoline d\'abord (l969) et le luth ensuite. En l975, il rejoint l\'orchestre de Mustapha Belkhodja où il est pris en charge par Salâh Boukli.      En 1981, il crée son propre orchestre et en 1985, il enregistre sa première cassette chez Rachid et Fethi. Il a été le premier à avoir enregistré sur cassette Sidi Boumediène.', 4, 'img_artistes/merioua.jpg', 1, 42, 150, '2024-10-15 15:37:47'),
(95, 'Blond blond', 'Blond-Blond de son vrai nom Albert Rouimi, du fait de son albinisme, est un célèbre chanteur du répertoire « francarabe », mélange de musiques orientales et occidentales en vogue avant-guerre. Il faisait partie de la communauté des Juifs d’Algérie. Enfant, Blond-Blond aime se retrouver dans des cafés pour écouter des chanteurs dont cheikh Larbi de Tlemcen et va faire ses premières vocalises auprès de Saoud El Medioni dit « l’Oranais », maître de la célèbre Reinette l’Oranaise. En 1937 il débarque à Paris et y interprète entre autres dans des radio-crochets, du Juanito Valdemara, du Trenet et du Chevalier, pour qui il porte une grande admiration. En 1939 il retourne à Oran, puis durant toute la guerre fait de multiples interprétations à travers l’Algérie et le Maroc, dans son style très particulier et nouveau, qui est léger et mouvementé, d’où son surnom de «l’ambianceur ». Il fait la connaissance de Lili Labassi qui l’influence de son répertoire chaabi et dont il interprète plusieurs de ses chansons. Blond-Blond maîtrise parfaitement le répertoire classique arabo-andalou mais préfére un répertoire plus contemporain influencé bien des fois par le tango et le flamenco, accompagné de paroles fantaisistes. En 1946 il retourne à Paris. Il partage sa carrière entre soirées privées faites de mariages et de circoncisions et des cabarets à la mode dont « Au Soleil d’Algérie », « El Djezaïr », « Les nuits du Liban », « Le Nomade ». Il accompagne également les célèbres artistes judéo-maghrébins Line Monty et Samy El Maghribi et sert à l’occasion de joueur de tambourin (tardji) auprès d’autres artistes maghrébins. Il est l’un des rares artistes judéo-maghrébins à chanter en 1962 à Asnières, pour l’indépendance de l’Algérie et retourne même en 1970 et en 1974 à Alger au « Koutoubia ». Blond-Blond le fantaisiste, l’ambianceur, disparait en 1999 à l’âge de 80 ans. Il est enterré au cimetière juif de Marseille . <>http://fr.wikipedia.org/wiki/Blond-Blond<>', 4, 'img_artistes/blond.jpg', 1, 32, 151, '2024-10-17 09:36:11'),
(96, 'El hadi elanka', 'À compléter', 4, 'img_artistes/hadi.jpg', 1, 33, 152, '2024-12-23 17:32:24'),
(97, 'Boualem Titiche', 'Boualem Mansouri dit Titiche naquit à El-Biar (Alger) le 27 avril 1908 au sein d\'un famille de mélomanes dont le père Hadj Ahmed (1867-l932), originaire de M\'zaïta (Mansourah), est lui même un maître zornadji qui s\'inscrit dans la noble lignée des grands maîtres de la Ghaîta tels Sid Ahmed Zernadji, El Hadj Ouali, Bouchakchak, Kouchouk, Sadani (décédé en 1933 à Chicago aux Etats Unis d\'Amérique). Héritant du pseudonyme \'\'Titiche\'\' attribué à son père à cause d\'un défaut de langue, ce virtuose de Ghaïta est une figure prestigieuse d\'un art musical aux racines populaires incarnant le vieil Alger. Il débute à l\'âge de 13 ans au sein du groupe de son père, zornadji de talent, en l\'accompagnant aux tbiblettes (petits tambours).\r\n\r\nEn 1932, il fonde son propre orchestre et fréquente El-Mossilia et El-Djazaïria. Il était apprécié et sollicité au moment des fêtes de mariages et des festivités culturelles organisées à Alger. Musique militaire d\'origine turque, joué en plein air, dans les villes de garnison telles Alger, Béjaia, Blida ou Koléa du 16 ème siècle jusqu\'à la conquête coloniale, la zorna s\'est développée dans la pratique rituelle religieuse et a évolué tout en s\'attachant au chant Chaâbi pour lequel elle servait d\'ouverture. Grâce à Boualem Titiche qui la dote de deux rythmes spéciaux, El Aadjani et EI-Quaiyate, elle devient structurée.\r\n\r\nL\'ensemble des musiciens de la zorna ont un habit traditionnel : Serwal testifa, un gilet brodé de fil d\'or appelé bédiaâ et une chéchia stamboul sur la tête .\r\n\r\nDans un souci de contribuer à la préservation de cette musique, Boualem Titiche l\'a enseigné au conservatoire d\'El-Biar. Plusieurs artistes parmi lesquels ses élèves ont été influencés par son genre tels que Mourad Guesmi (au tbal), Halim (à la Ghaïta) et Moumène qui crée par la suite sa propre troupe \"Nouba\". Il mourut le 1er décembre 1989 à Alger.', 4, 'img_artistes/titiche.png', 1, 155, 150, '2025-09-07 12:50:13'),
(108, 'Chafia boudraa', 'Chafia Boudrâa (1930–2022)\r\nChafia Boudrâa, de son vrai nom Atika Boudrâa, est née le 22 avril 1930 à Constantine, en Algérie. Figure emblématique du théâtre, du cinéma et de la télévision algérienne, elle a marqué plusieurs générations par son talent, sa sensibilité et son engagement artistique.\r\n\r\n🌟 Débuts et ascension\r\nEn 1964, elle quitte sa ville natale pour s’installer à Alger, où elle entame une carrière de comédienne malgré des débuts difficiles. C’est dans le feuilleton télévisé « El Hariq » (L’Incendie), adapté du roman de Mohamed Dib et réalisé par Mustapha Badie, qu’elle se révèle au grand public. Son interprétation du personnage de « Lalla Aini » devient culte et lui vaut une reconnaissance nationale.\r\n\r\n🎬 Carrière cinématographique\r\nChafia Boudrâa a joué dans une douzaine de films marquants du cinéma algérien, parmi lesquels :\r\n\r\nL’Évasion de Hassan Terro de Mustapha Badie (1974)\r\n\r\nUne femme pour mon fils d’Ali Ghalem (1982)\r\n\r\nLe thé à la menthe d’Abdelkrim Bahloul (1984)\r\n\r\nLe mariage de Moussa de Tayeb Mefti\r\n\r\nLeila et les autres de Sid Ali Mazif\r\n\r\nUn vampire au paradis de Abdelkrim Bahloul\r\n\r\nLe cri des hommes de Okacha Touita\r\n\r\nHors-la-loi de Rachid Bouchareb (2010), présenté en compétition officielle au Festival de Cannes, où elle incarne la mère des trois protagonistes.\r\n\r\n📺 Télévision et théâtre\r\nOutre ses rôles au cinéma, elle a participé à plusieurs productions télévisées algériennes et françaises, dont :\r\n\r\nSixième gauche de Claire Blangille\r\n\r\nLe Secret d’Elissa Rhaïs de Jacques Otmezguine\r\n\r\nL’un contre l’autre de Dominique Baron\r\n\r\nJust like a woman (2012) et L’honneur de ma famille de Rachid Bouchareb\r\n\r\nAu théâtre, elle a brillé dans des pièces comme La Mégère apprivoisée au Théâtre national d’Alger, où elle interprète le rôle de la veuve. Elle a également participé à un monologue poignant sur la condition féminine, mis en scène par Hamida Ait El Hadj.\r\n\r\n🕊 Vie personnelle et hommage\r\nVeuve d’un chahid du Front de Libération National (FLN), tombé au combat en 1960, Chafia Boudrâa a toujours porté en elle les valeurs de dignité et de mémoire. Elle s’est éteinte le dimanche 22 mai 2022 à Alger, à l’âge de 92 ans.\r\n\r\nSon décès a suscité une vive émotion dans le monde artistique algérien. De nombreux hommages lui ont été rendus, notamment par le Théâtre national d’Alger, le Festival du film arabe d’Oran et le Festival du film de Mascate, saluant son immense contribution à la culture algérienne.', 4, 'img_artistes/boudraa.jpeg', 1, 161, 202, '2025-10-07 14:07:54'),
(98, 'Mohamed ghafour', 'Né le 5 mars l930 à Nédroma (Tlemcen) Brillant interprète de Hawzi. \r\nEtudes de français à l\'école des garçons de la ville et, pendant les moments creux, il prend des leçons de Coran et de Fiqh à la mosquée chez cheikh Lefçih. Bien que brillant élève, il dut quitter l\'école pour aider son père, tisserand de son état. En 1948, son oncle drabki commence à s\'intéresser à sa voix. Il rejoint l\'un des nombreux orchestres de la ville, celui de Hadj Ghenim Naqqache ou il apprend la darbouka pendant trois mois, puis la mandoline durant deux ans. Ensuite il rejoint un autre maître, Driss Rahal avec qui il reste jusque en 1953.Le reste ce sont les cercles littéraires de la Mesria et Tarbiaâ qui le feront. C\'est là que le jeune Ghafour apprend à se maîtriser, à s\'assumer. Les années 55-62 constituent la période la plus creuse et 1a plus noire de son existence. Après l\'indépendance la reprise est dure. Ce n\'est qu\'en 1966, lors du premier festival de la musique andalouse d\'Alger, qu\'il a consenti à reprendre. De 1966 à 1970, il se révèle au public algérien. Il participe à tous les festivals de la musique andalouse.\r\n\r\n \r\nEn plus de Nédroma, Alger et Constantine vont constituer ses ports d\'attache musicaux. En 1969, son ensemble obtient le premier prix au Festival de la musique populaire d\'Alger pour l\'interprétation de Ya Welfi Mériem. Hadj Ghafour demeure un cas original dans la mesure ou il n\'a jamais enregistré ni disques (l\'unique disque est sorti des presses de la défunte unité des Eucalyptus de l\'ex -RTA ), ni cassettes. Sa modestie est exemplaire : J\'ai chanté parce qu\'un jour cheikh Ghenim l\'a imposé. .. J\'ai continué à le faire parce que cela me plaisait. J\'ai persisté parce que cela plaisait aux autres. Maintenant je ne le fais plus parce que je suis malade. dit-il, en février 1986 , à un journaliste d\'El Moudjahid . Après sa décision d’arrêter de chanter en 1981 à cause d\'un ulcère de l\'estomac, cheikh Ghafour fréquente régulièrement les zaouïas de la région en se consacrant au mdih. En vingt ans de carrière (de 1960 à 1980), Ghafour s\'est produit plusieurs fois gratuitement pour l\'amour du métier. N\'ayant jamais écrit de textes ni composé de musiques il puisait dans les richesses de Bensahla , Benachour, Si Driss Berrahal. Il ne possède aucune de ses cassettes chez lui et \"n\'aimait plus écouter sa voix\'\'. Père de huit enfants qui écoutent tous les genres de musique, le cheikh passe le plus clair du temps dans son atelier de confection. C\'est d\'ailleurs en 1948, dans un autre atelier, de tissage celui-là, tenu par son oncle, qu\'il fit la connaissance avec la musique. Mais sa carrière artistique ne commence vraiment qu\'en 1962. Ne pouvant supporter le rythme infernal des soirées, il dut s\'offrir une récréation de deux ans (1972 à 1974). Le hawzi ou le Malouf de Hadj Ghafour a un cachet particulier, propre à Nédroma. Et c\'est son frère cadet, Abderrazak, qui enregistra une cassette en 1991 aux éditions de Nédroma, pour perpétuer le genre pratiqué par la famille.\r\n\r\nSources : \"Dictionnaire des musiciens et interprétes algeriens\" de Achour CHEURFI', 4, 'img_hawzi/El Hadj Mohamed el Ghaffour.png', 6, 154, 150, '2025-09-09 12:39:00'),
(99, 'Dahmane ben achour', '(1912 -1976) - Figure de la musique classique algérienne.\r\nDe son vrai nom Achour Abderrahmane, Dahmane Ben Achour est né le 11 mars 1912 à Ouled Yaïch (Blida). Il fréquente l\'école coranique, ayant pour maître son grand-père, puis exerce le métier de coiffeur avant de se lancer dans la musique qui ne tarde pas à absorber toute son activité. Dès son jeune âge, Abderrahmane s\'installe à Alger, rue Zama, avec ses parents. Son père était commerçant, place des Martyrs. Quelque temps après, son père avant acquis un commerce à Blida, il s\'y installe à son tour, comme coiffeur. C\'est dans ce salon de coiffure, qu\'il débute musicien, jouant d\'abord du mandole, accompagné par l\'un de ses amis, Ali Mili issu des grandes écoles de l\'art classique, il se fait remarquer en 1931, par sa belle voix au sein de la société blidéenne de musique El-Adabia, que préside Chérif Bencherchali.\r\n\r\nC\'est au sein de cette association qu\'il côtoya des musiciens plus rodés que lui comme par exemple Hadj Medjbeur qui deviendra par la suite son bras droit, su violon, dans l\'orchestre.Khellil, Boualem Stamairo ainsi que d\'autres musiciens avaient acquis, en leur temps, le sens du métier pour avoir travaillé sous la conduite d\'un grand maître du aroubi de la Mitidja, Mahmoud Oulid Sidi Saïd. Pris en estime par Hadi Medjbeur, Dabmane fait beaucoup de progrès et supplanta tous les jeunes de sa promotion. Il adhère à El-widadia dès sa création en 1934. Guidé par le grand musicologue Mahieddine Lakchal, Dahmane apprit les noubas, les rythmes, le sens des poésies. Il connaît les meilleurs moments de sa carrière à partir de l 940 même si sa participation en 1939, à la fête du Trône, au Maroc, n\'est pas passée inapercue\r\n\r\nDès 1946, i1 acquiert au sein de l\'orchestre dirigé par Mohamed Fakhardji une connaissance encore plus solide de la musique andalouse et très vite, devient un spécialiste du hadri(Hadhra) traditionnel. Dahmane Benachour jouait de tous les instruments et maîtrisait bien les styles Aroubi et Hawzi Son orchestre se composait de Hadj Medjbeur au violon, Benchoubane au mondole,Barabas à la flûte, Challal et Baba-Ameur au tambourin. Cet artiste de talent, demandé de partout par les connaisseurs, donne son dernier spectacle en juillet 1976 à El- Achour (Alger).Meurt le 15 septembre 1976 à Blida suite à une intervention hirurgicale.', 4, 'img_hawzi/benachour.png', 6, 150, 150, '2025-09-09 13:48:44'),
(100, 'Rachid nouni', '(né en 1943-1999) - lnterprète de Chaâbi.\r\nNé 1e 5 mai 1943 à Blida et et mort le 2 mars 1999. Sensible à la musique orientales il commence dans les années 50 à chantonner les airs de Mohamed Abdel wahab. L\'amoureux de la guesba et le cheikh Bouras, dès les premières années de l\'indépendance, fera partie d\'un groupe de chaâbi \"l\'union artistique populaire\'\' en tant que terrar et drabki par la suite sous la direction de Mohamed Bouzerar . Composé de Settouf, Tass, Mrizek, Semmad, Hadj Benchoubane - responsable de théâtre de Bouzerar bien-sûr et de Ali Métidji, chef d\'orchestre. la troupe ne va pas chômer.\r\n \r\nAidé par Hadj Mohamed Saoudi, pâtissier de la rue Baj, Rachid Nouni va perfectionner son jeu du mendole. Pour ce fonctionnaire des finances (Crédit Populaire Algérien), à la voix velouter, aux intonations traînantes, le chaâbi ne sera jamais un métier mais un art. Ce \"chanteur local\'\' comme il se définit modestement lui-même, a enregistré cinq K7 (1993). Il apprécie Verlaine et le jazz.', 4, 'img_artistes/nouni.jpg', 1, 150, 150, '2025-09-09 14:25:00'),
(101, 'M\'hamed bourahla', '(1918-1984) - Brillant Interprète de chaâbi..\r\nNé le 8 février 1918 à Koléa, coiffeur, M\'hamed Bourahla a eu dès sa plus tendre enfance, un penchant pour la musique, devenue sa véritable passion, encourage d\'abord par son père également musicien, il bénéficia ensuite du concours d\'Ali Biroune. Fascine par la magie du chaâbi, le charme de sa musique et l\'incantation poétique qui parfumaient agréablement l\'espace du quartier ou il est né, cheikh Bourahla prit le départ d\'un parcours assez difficile. Jouissant d\'une bonne réputation, il commença par constituer un répertoire au fil des soirées qu\'il donna dans différentes circonstances à partir de 1946. Appréciant énormément le travail et la valeur du maître Hadj M\'hamed El-Anka dans le chant chaâbi.\r\n 	\r\nBourahla trouva en lui un conseiller des plus précieux. Son passage à la radio en 1947 fut une révélation el les mélomanes les plus avertis découvrirent un cheikh digne de la noblesse du chaâbi. Après ces premiers succès, Bourahla est sollicité, un peu partout pour animer diverses fêtes, mariages, baptêmes, réceptions, etc. Il n\'a jamais tenté d\'imiter le style de tel ou tel chanteur, il a son propre genre avec lequel il arrive à convaincre, sa voix chaude, envoûtante, un Mandole qu\'il maîtrise avec assurance et précision, ses Touchiates, Istikhbars. et qacidates sont exécutés magistralement. Il se rendit au Maroc ou il rencontra l\'illustre poète Driss El-Alami qui le guida dans la voie de la poésie populaire Bourahla avait à son actif des passages à la radio et à la télé ainsi que des enregistrements des chansons de son répertoire telles que Yama dha sare. Ya hmama et une chanson sportive Nedjmâ Koléeîa dédiée au club de football local l\'ESMK. Cependant, de toutes ses chansons, El-Meknassia avait sa préférence. Mourut en septembre 1984. Son Fils Sid-Ahmed a pris sa relève...', 4, 'img_artistes/bourahla.png', 1, 154, 151, '2025-09-09 14:38:50'),
(102, 'Kamel bouda', ' (né en 1957) - Brillant interprète de Malouf\r\nNé le 8 mars 1957 à Constantine. Scolarité : d\'abord à El Ketania, une école dont l\'édifice se trouve près de la tombe de Salah Bey. Cette médersa est très célèbre. Située dans la vieille ville (à Souk El Asser), elle garde les aspects de l’urbanise Khaldounien. El Omran El Hadhari . Le lycée Rédha Houhou insolite qui constitue un chef d’œuvre architectural et d\'où de nombreuses promotions de bacheliers sont sorties. Un lycée référence.\r\nLe jeune Kamel Bouda a commencé ses débuts artistiques en chant individuel et dans les chorales au lycée où il émergea du lot\r\nS\'intéressant au patrimoine andalou Constantinois notamment le malouf, le Hawzi. et le Mahdjouz. ? il a également excellé dans le Zadjal. qui est une forme d\'expression poétique en arabe dialectal comparativement au Mouachchah. . Il fréquenta le Conservatoire sous la direction de Cheikh Kaddour Darsouni et Brahim El Amouchi notamment où des prestations musicales s\'organisaient sous le générique de \"Gai jeudi\", Avec sa belle voix Kamel Bouda devient vite le \"rossignol\'\' du Vieux Rocher. Il va du soprano au baryton malgré son jeune âge.\r\n\r\nIl fut primé dans de nombreuses festivités. Festival de la chanson algérienne : premier prix avec Kaddour Darsouni . Kamel Bouda interpréta la chanson Dawi ya Adra Hali (0 vierge, guéris mon mal) . Très sollicité dans les mariages et les noces des familles constantinoises et dans tout l\'Est du pays. Quelques passages marquant à la télévision où il a interprété l\'opérette Samra ou Beida (La brune et la blonde). Il est de ceux qui ont introduit le bendir et les dikrs des Aissaouas dans l\'orchestre ; Constantinois (interprétation des mdih.). Continue à perfectionner ses récitals en ajoutant l\'interprétation de Nouba telles noubat El Maya (Layali Sourour) et noubat El Resd qui est la reine des noubates. Il semble être emporté par l\'octave ferganienne et la technicité de Raymond. Il a de l\'admiration pour Chaou, Guerouabi et Koufi ...', 4, 'img_malouf/bouda.jpeg', 7, 150, 150, '2025-09-09 14:50:53'),
(104, 'Tetma cheikha', '(1891- 1962) - Brillante interprète du genre Hawfi\r\nDe son vrai nom Tetma Thabet. Cheikha Tetma est née à Tlemcen. Elle entaima sa carrière en interprétant le hawfi qui est une sorte de romance, de berceuse que les femmes tlemcéniennes chantaient en se poussant sur la balançoire ou en cajolant leur bébé pour l\'endormir, ou encore pour meubler les soirées familiales... Un exemple:\r\n\r\n\"j\'ai découvert des rochers entre lesquels coulait une eau abondante.\r\nje me suis rendu aux cascades pour les visiter\r\nJ\'ai remarqué quatre jeunes femmes qui lavaient du linge\r\n\'\'la première ô lune, la deuxième du cristal,\r\n\"la troisième ô mon frère a enflammé mon coeur,\r\n\'\'Et la quatrième, ô mon fère, une brûlure sans feu \'\'.\r\nSon étoile monda très vite au firmament, car elle était dotée d\'une voix ensorcelante, mais plus encore, elle jouait parfaitement de la kouitra et du violon . Son niveau d\'instruction en arabe était appréciable pour l\'époque; elle pouvait de ce fait assimiler très vite les poèmes qu\'on lui présentait en y ajoutant la manière .\r\n\r\nElle était accompagner d\'un orchestre composé de Omar El-Bekhchi, de Abdelkrim Dali lorsqu\'il était jeune et du virtuose du piano Djillali Zerrouki. Ce dernier lui était fidèle; il a participé, en effets avec elle à toutes les cérémonies qu\'elle animait à travers tout le pays, mais aussi au Maroc et en France, et il exécutait avec un brio incomparable les Istikhbar dans les modes Zidan, Mawwal, sika et autres sahli et âarêq.\r\n\r\nSa virtuosité n\'était pas sans écho, car elle trouvait du répondant dans l\'exécution de Cheikha Tetma. La dextérité de ce grand maître du piano reflétait l\'ombre parfaite et assidue de la voix ondulante de Tetma. Du hawfi, Cheikha Tetma fit un passage très aisé au Hawzi et interpréta ainsi les oeuvres des célébres maîtres Ben Msayyeb, El-Yacoubi, Mohamed et Boumediène Bensahla, Bentriki et Ahmed Zengli.\r\n\r\nPlus tard elle s \'exerça également à la musique classique andalouse. En elle participa à une tentative d\'harmonisation andalouse initiée par un orchestre symphonique européen du Conservatoire municipal d\'Oran. Elle est sortie grandie de cette expérience au point où elle s\'installa à Alger, durant une grande partie des années cinquante.', 4, 'img_hawzi/tetma.png', 6, 150, 151, '2025-09-09 15:21:33'),
(105, 'Mehdi tamache', 'Né à Bologhine (Alger) (né en 1951)- Interprète de Chaâbi, de 1968 à 1975, il suit les cours de M\'hamed El-Anka au Conservatoire d\'Alger.\n\nTravaillant dans une imprimerie, il fait de la musique avec beaucoup d\'amour. Sa carrière débute juste après sa sortie du Conservatoire et déjà, en 1977, il représentait l\'espoir de la chanson chaâbie.', 4, 'img_artistes/tamache.jpg', 1, 150, 152, '2025-09-10 10:15:52'),
(106, 'Boualem rahma', 'Né le 24 avril 1941 à la Haute Casbah (Alger).  (né en 1941)- Interprète de Chaâbi\n\nSecond fils d\'une famille modeste, enfant déjà, i1 succombe aux charmes des mélodies du chaâbi.\n\nA la sortie de l\'école, il se précipite régulièrement au Conservatoire municipal. Un deuxième prix récompensera le jeune talent. Après des débuts en classe classique dirigée par Abderrahmane Belhocine, Boualem passera respectivement chez Abdelkrim Dali, Iguerbouchène et M\'hamed El-Anka.\n\nA 15 ans, il fera ses premiers pas à la radio. Mais les temps sont durs et la guerre fait rage. Il est difficile pour l\'adolescent de réconcilier l\'école, la musique et les petits boulots.\nDe vendeur de journaux à la criée jusqu\'à l\'apprentissage de la pâtisserie qui deviendra son véritable métier, Boualem garde intacte sa passion pour la musique et à l8 ans il s\'initie à la composition.\n\nEl-Hamdou lilah Kitlaâ laâlam (Dieu Merci, le drapeau flotte) sera sa première création musicale. Emigré clandestin à Paris après l\'indépendance, il se décide un jour, dans la cafêtte que tient le grand artiste Salah Saâdaoui, de chanter sa mère et l\'exil, Adhili Belkheir ya Loumima, allait vite devenir un tube qui le propulse dans le gotha des super-stars du chaâbi.\n\nNous sommes en 1970. Mais une autre passion habite le maître du chaâbi. le sport et surtout le football à qui il consacra de nombreuses chansons. Auteur et compositeur, Rahma Boualem a son actif une dizaine de disques, Yalmmima est l\'un de ses succès. Ses thèmes préférés sont les thèmes sociaux. patriotiques et religieux (Nabaoui et Gharbaoui). Ce pâtissier de profession, chante l\'exil, l\'espoir, la foi.', 4, 'img_artistes/rahma.png', 1, 158, 152, '2025-09-10 11:02:15'),
(107, 'Mohamed Tobal', '(mort en 1993) - Interprète de Chaâbi et de Hawzi\r\nNé à Blida, en 1963, il crée avec des amis du quartier populaire d\'El-Djoun une troupe musicale Nedjma. A près un brève passage dans l\'association El-Widadia, il décide de poursaivre son chemin en solitaire. Ne sort sa première cassette qu\'en 1991 intitulée Kikanet El-Blida. Cette dernière contient quatre chansons : Ya dho Ayani (Lumière de mes yeux), poème sur la ville de Tlemcen; un Qsid sur Sidi Brahim El-Ghobrini de Cherchell; Ma Bqet Dounya et enfin Kikanet El-Blida de Omar EI-Ghoribi. Il meurt au mois de juillet 1993.', 4, 'img_hawzi/tobal.png', 6, 151, 151, '2025-09-10 12:56:31'),
(109, 'Sid Hamed Lahbib', 'pas prete', 4, 'img_artistes/sid_ahmed_lahbib.jpg', 1, 184, 150, '2025-10-14 11:44:11'),
(110, 'Reda Djillali', 'Cheikh Reda Djillali (1936–2019) : Une voix emblématique du chaâbi algérien\n\nNé le 8 mars 1936 dans le quartier populaire de Kouba à Alger, Cheikh Reda Djillali s’est imposé comme l’une des grandes voix de la musique chaâbi, ce répertoire lyrique profondément ancré dans la culture algérienne. Fils du mufti et érudit Abderrahmane Djillali, lui-même passionné de musique andalouse, Reda grandit dans un environnement où la spiritualité et l’art musical se côtoient harmonieusement.\n\nDès l’âge de 15 ans, il intègre le Conservatoire d’Alger, où il reçoit l’enseignement de maîtres incontournables : Abderezak Fekhardji pour la musique classique et andalouse, et surtout El Hadj M’hamed El Anka, figure tutélaire du chaâbi moderne. Cette double formation lui confère une maîtrise rare, mêlant rigueur andalouse et expressivité chaâbie.\n\nAprès l’indépendance de l’Algérie, Reda Djillali devient professeur de musique andalouse, transmettant avec dévouement ce patrimoine aux nouvelles générations. À la fin des années 1970, il s’installe en France, où il poursuit sa carrière artistique en collaborant notamment avec le chef d’orchestre et compositeur Boudjemia Merzak. Il enseigne également au Centre Culturel Algérien à Paris ainsi qu’à la MJC d’Argenteuil, restant fidèle à sa mission de transmission.\n\nArtiste discret mais profondément engagé, Reda Djillali laisse derrière lui un héritage musical précieux, incarné par des qacidate (poèmes lyriques chantés) devenues des classiques du genre : « Ya Ali Chouf Edjbel El Gharb », « Nada Ouakt Essourour » ou encore « Moul Ennia ». Sa voix claire, douce et empreinte d’émotion continue de résonner dans les mémoires des amateurs de chaâbi authentique. L’un de ses titres a même été repris par l’Orchestre National de Barbès (O.N.B.), signe de sa reconnaissance au sein de la scène musicale algérienne.\n\nIl participe également à des projets majeurs de rayonnement culturel, comme la tournée internationale « El Gusto », initiée par la cinéaste Safinez Bousbia. Aux côtés de figures légendaires telles qu’Abdelmadjid Meskoud, Abdelkader Chercham, El Yamine, Maurice El Medioni ou Robert Castel, il se produit notamment lors d’un concert mémorable à Bercy en 2011, célébrant la réconciliation et la richesse de la musique algérienne.\n\nEn juin 2019, quelques mois avant sa disparition, l’ensemble Al Andalus, dirigé par Samia Abdenour, lui rend hommage au Centre Culturel Algérien à Paris, aux côtés de son compère Amar Achab, avec qui il avait partagé la scène à la salle El Mouggar à Alger.\n\nCheikh Reda Djillali s’est éteint le 5 octobre 2019 à Paris, à l’âge de 83 ans. Inhumé au cimetière musulman de Thiais (Val-de-Marne), il laisse derrière lui une œuvre sobre mais puissante, marquée par l’élégance, la piété et l’amour inconditionnel de la musique algérienne.\n\nAllah yerhamou.\nMahfoud@webchaabi.com', 4, 'img_artistes/reda_el_djilali-2001.jpg', 1, 162, 150, '2025-10-22 07:32:10'),
(112, 'Noureddine Alane', 'Pas Ecore Prete', 4, 'img_artistes/noureddine_alane.jpg', 1, 5, 5, '2025-10-26 13:37:30');

-- --------------------------------------------------------

--
-- Structure de la table `bouqalla`
--

DROP TABLE IF EXISTS `bouqalla`;
CREATE TABLE IF NOT EXISTS `bouqalla` (
  `id` int NOT NULL AUTO_INCREMENT,
  `num` int DEFAULT NULL,
  `arabe` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `phonetic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `français` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bouqalla`
--

INSERT INTO `bouqalla` (`id`, `num`, `arabe`, `phonetic`, `français`) VALUES
(1, 1, 'ايلا أنت بحرأنـا حوتـة فيك ويلا أنت جنان أنا وردة فيك وايلا \r\nأنت تحبني أنا نموت عليك', 'ila anta abhar ana houta fik wa il anta adjnen ana warda fik wa ila anta athabni ana anmout aâlik', 'Si tu es la mer, moi je suis un poisson qui nage dans ton eau, et si tu es un jardin, moi je suis une fleur plantée dans ta terre et si tu m’aimes, moi je meurs d’amour pour toi'),
(2, 2, 'طليت على البحر وشتكيتلو همي أنطق ليا البحروقالي فرج ربي وبحبك \r\nسالم غانم والتكلان على ربي \r\n', 'tallit aâla labhar wa ch\'tkitlou hammi antek liya labhar ou kalli ayfaredj rabbi wa bi hobek sallem ghanem wa ataklen aâla rabbi ', 'J’ai contemplé la mer, pour lui confié mes chagrins, \"Dieu apaisera tes peines, m\'a-t-elle répondu et, protégera ton Amour.\r\nIl est le seul sur qui comptait\"'),
(3, 3, 'حنة ياحنة يامعطرة\r\nبروايح الجنة جيني في السيرة والسنــة لـي هـبل ', 'Aydawi bik ou yathanna hanna ya ahnina ya amaâtra bi arwayeh el djanna djini fi essira wa essana liya Ah\'bal ', 'Tu es son remède et son bien-être, ô henné, henné parfumée par l’odeur du paradis tu es dans mes pensées et l\'attente est dure pour moi '),
(4, 4, 'خرجت فـي نصـاف\r\nالـيالـي وطلـبت معبودي قلت يـاربـي اجمع شملي مع شمل محبوبي', 'Akhredjt fi anssef elyali wa atlebt maâboudi kolt :\" ya rabbi adjmaâ chamli maâ chaml mahboubi \"', 'Je suis sortie au milieu de la nuit et j’ai prié le bon dieu en lui disant :\" mon dieu faites-moi rencontrer mon bien-aimé \" '),
(5, 5, 'جاء المعلم اللي\r\nوالفتو وخياله بين عينيـا ذوك 100مـايجوش كـيف سيرتـو فـي العقليــة', 'Dja lamaâlem li waleftou wa akhyalou bin aâyniya douk amya maydjiwchkif sirtou fi el aâklya', 'Le maître à qui je me suis habituée est revenu, son image est entre mes yeux, si j’avais à choisir entre 100 hommes, personne ne lui sera égal, ni dans son comportement ni dans son raisonnement '),
(6, 6, 'خارجة من الحمام\r\nوخدودهـا يحمـاروا اللـي وريلـي دارها يعمرولوا داروا ', 'Khardja min alhamam wa akhdoudha yahmarou ly iwarili darha ihamarlou darou.', 'Elle est sortie du hammam, ses joues rougies, celui qui me montre son logis, sa maison se remplira de bonheur et de joie.'),
(7, 7, 'غـالـي غالـي والـغـالـي ربـي مهمـا\r\nأتروح وتغيـب معزتـك فـي قلبـي', 'Ghali, ghali wa el ghali rabbi, mahma atrouh wa atghib amaâztek fi kalbi ', 'cher , cher et le plus cher est le bon dieu, malgré ton absence, ton amour sera toujours dans mon cœur '),
(8, 8, 'طلعت للسطح قلت لحبيبي بلاك تنساتـي\r\nياخلبلي محبتك في قلبي كالجوهر الحقانـــي', 'Atlaât lasstah, koult lahbibi balek tanssani yakhi libali amhabtek fi kalbi ki el djouhar el hakkani ', 'Je suis monté à la terrasse, j’ai dis à mon bien-aimé:\" attention tu m’oublies, toi qui es dans mes pensées, ton amour est dans mon cœur et rien ne peut le changer comme nul ne peut changer ni souiller une vraie perle de culture\"'),
(9, 9, 'هبطت لقاع البحر وحنيت يديهاوقلت ربي\r\nكملي متراني متمنية', 'Ahbet el kaâ labhar ou hanit yaddiha ou kolt rabbi kamelli matrani matmanya', 'Je suis descendu au fond de l\'océan, j’ai mis le henné à mes mains, j’ai dis au bon dieu : \" réalisez-moi mon souhait qui me tiens à cœur \" '),
(10, 10, 'نمت والله والمنام رؤيـة من عندي ربـي\r\nحمامـة بيضاء جات حطت عليا', 'nemt ou lamnem roaya min aândi, rabbi ahmama bida djet hatet aâliya', 'J\'ai rêvé, et mon rêve est une vraie vision, une colombe blanche s’est posé sur moi '),
(11, 11, 'مشيت الليل وحـدي\r\nوأنـا نبكي وأناأنـادي ياربي لعزيز سقملي سعدي', 'Amchit allil wahdi wana nabki wana annadi, ya rabbi laâziz sagamli saâdi ', 'j’ai marché seule dans la nuit en pleurant et en criant : \" bon dieu donnez-moi ma chance! \" '),
(12, 12, 'المنجل عمرو مايسوى القلب مايحب غير اللي\r\nيهوى', 'El mandjel aâmrou mayasswi, el kalb ma ayhab ghir alli yahwa', 'La faucille est arquée et ne se redresse jamais, et le cœur n’aime que celui qu’il a choisi '),
(13, 13, 'عينيك تـوت وحواجـبك يـاقـوت أنـا نديـك\r\nواللـي يبغـي يموت يموت', 'Aâynik toute wa ahwedjbek yakout ana nadik walli yabghi aymout aymout ', 'Tes yeux sont noirs comme des mûres, et tes sourcils comme des rubis;\r\nTu seras à  moi; et celui qui veut mourir, qu\'il meurt'),
(14, 14, 'غرست ياسمينة فـي وسـط الـدار كـبرت ومـدت لزهار مابـيـا والو\r\nغير غدر الجار ', 'Aghrasst yassmina fi wasst addar, kabret ou madet lazhar mabiya walou ghir ghadr el djare ', 'j’ai planté un jasmin au centre de la maison, le jasmin a grandi et a fleuri, je n’ai pas à me plaindre sauf de la trahison du voisin'),
(15, 15, 'عيني عي عين لحبيب\r\nولسانـي حـاشـم تمنيت ندير الحنة ونزيد الخاتم', 'Ayni ayn lahbib wa alssani hacheme atmanit andir el hanna wa anzid el khatem ', 'Mes yeux ne voient que mon bien-aimé et je n’ose prononcer un mot j’espère que je mettrai le henné à mes mains et la bague à mon doigt '),
(16, 16, 'يـدى فـي يد خويا ويد\r\nخويا بالحنة واليوم سعدو هو وغدو ة أنا نتهـى', 'yadi fi yed khouya, ou yed khouya bi el hanna, wa el youm saâdou houwa ou ghdwa anna nathanna', 'Ma main tiens la main de mon frère, et la main de mon frère est décorée de henné, aujourd’hui il a le bonheur de fêter son mariage et demain viendra mon tour'),
(17, 17, 'جايز على باب دارنا سكران يترامي قالي ياخليلتي أعطيني شوية\r\nماء وكي سقيتوا ردلي في طبق خوخة ورمانة ', 'assfina tadjri atwassikoum ya abnet la takhdou el bahri, yarmi akloub fi echabka b\'la chafka wa aykhalli admouâa tadjri ou tadjri ', '18 Le bateau avançait à grande vitesse et a conseillé les jeunes filles de ne jamais épouser un marin, il jette vos cœurs dans le filet sans scrupules et sans regret il laisse couler, couler vos larmes '),
(18, 18, 'سفينة تجري توصيكم يابنات لاتاخذوا لبحري\r\nيرمي قلوب الشبكة بلا شفقة ويخلي دموع تجري وتجري	', 'assfina tadjri atwassikoum ya abnet la takhdou el bahri, yarmi akloub fi echabka b\'la chafka wa aykhalli admouâa tadjri ou tadjri ', 'Le bateau avançait à grande vitesse, je conseille les jeunes filles de ne jamais épouser un marin, il jette vos cœurs dans le filet sans scrupules et sans regret il laisse couler, couler vos larmes'),
(19, 19, 'فمي فمك في الكاس\r\nوسري وسرك واش وصلوا للناس سري زجاج اذا تكسر خلاص', 'Fammi, fammek fi kess ou sarri ou sarrek wach wasslou laness, sarri azdjedj ida atkassar akhlass', 'Ma bouche et ta bouche boivent du même verre, mon secret et ton secret qui l’a fait divulguer au gens? Mon secret est en verre, s’il se casse rien ne se répare '),
(20, 20, 'حبطت لقاع جنان صبت لملاح الرقود تقسمت الدالية واتنهد\r\nالعنقود غالي والغالي مها تروح وتغيب', 'Ahbet al kaâ adjnen sabt lamleh arkoud atkassmet eddalia wa atnahhed el aânkoud :\" ghalli, wa el ghali mahma atrouh wa atghib \"', 'Je suis allé au fond du jardin, j\'ai trouvé les bonnes gens apaisés dans leur sommeil, la dalia s\'est penchée sur eux et la grappe de raisin a soupiré: \" oh, mon bien aimé, tu  resteras dans mon cœur à jamais malgré ton départ et ton absence\". \r\n'),
(21, 21, 'حبك فـي قلبـي وعليـك\r\nياحبيبـي أنـا قـاقبلــة نقبل ونتوفــى ', 'Wa aâlik ya ahbibi anna kabla nakbel ou natwaffa ', ' Oh! mon bien-aimé, je suis d’accord! je t’accepte et je meurs '),
(22, 22, 'أرفت أبريقـي\r\nوترضيــت وربـي أعطــانـي ماتمنــيت', 'Arfet abriki wa atwaddit ou rabbi aâtanni ma atmanit', 'J\'ai pris mon alambic pour faire mes ablutions, et sitôt Dieu a exhaussé mes prières '),
(23, 23, 'كـي تلقـا المليح مع المليح يتوادو البنينة وكـي تلاقا\r\nالمليح مع الدوني يشبعو الغبينة وكي تلاقا الدوني مع الدوني يغرقوا السفينـة', 'Ki talka lamlih amâa lamlih yatwaddou, el bannina ou ki talka lamlih amaâ eddouni yachabaôu laghbina ou ki talka eddouni m\'âa eddouni aygharkou essfina ', 'Quand tu trouves une bonne personne avec une bonne personne, ils se veulent du bien et quand tu trouves une bonne personne avec une mauvaise personne ils vivront dans le malheur et quand tu trouves une mauvaise personne avec une mauvaise personne ils couleront le bateau'),
(24, 24, 'حبطت لقاع البحر لقيت البحر يغلي خرجت لي جنية قالت لي واش\r\nبيك ياسعدية حبيبك جاي وجايبلك هديـة', 'Ahbet el kaâ labhar alkit labhar yaghli, khardjet li djaniya kaletli  :\" wech bik ya sâadiya ? ahbibek djey ou djayeblek ahdiya \"', 'Je suis descendue au fond de l\'océan déchainé, et j\'ai rencontré une sirène qui m\'a dit: \"que t\'arrive-t-il  oh saâdia ? ton bien-aimé est de retour et il t\'apportera un cadeau\".'),
(25, 25, 'السمرة ياسمرة يالـي\r\nحلـوة كــي الـتمـرة عـيونـك شهلـة ولسانك جمرة', 'Assamra! ya essamra,  yalli ahlouwa ki ettamra, aâyounek chahla wa el sanek djamra!', 'Brune, oh la brune!, tu es aussi délicieuse qu\'une datte, tes yeux sont de miel et ta langue de braise !'),
(26, 26, 'كنت كي الوردة المذبالة جاء حبيبي وغير الحالة ياخويا الحب\r\nراه كواني ودواه راه شفاني ', 'Kount ki el warda el madbala  dja ahbibi ou ghir el hala ya khouya, el hob rahou akwani ou adweh rahou achfani', 'J\'étais comme une fleur fanée mais mon bien-aimé est revenu, oh! mon frère! l\'amour m\'a brûlé le cœur et m\'a guérie.'),
(27, 27, 'وفي زمـاني ولهانـه يالوكان تجي وتجيني وتديني معاك وماتخايني راني في الحب عشقانـة ', 'Ou fi azmani walhana, ya louken atdji wa atdjini ou tadini amâak ou matkhayenni rani fi el hob aâchkana', 'En ce moment je suis oisive mais si tu rentres et tu me reviens, et tu me prends avec toi,  sans me trahir,  je serai toujours amoureuse de toi'),
(28, 28, 'الدموع من العيون سيالة والقلوب دايرة\r\nوجوالة وانا نتعذب ونفاسي ونقول وين حبابي وين ناسي ونقول ياليل ياعين', ' Admouaâ fi  laâyoun sayyala ou  lakloub dayyara  ou djawwala wana natâadeb wa ankassi wa ankoul win ahbebi, win nassi wa ankoul ya lil ya aâyn', 'Les yeux pleurent, et les cœurs sont tourmentés, et moi je suis dans le désarroi et je vis sans tranquillité et je me dis : \"Où sont passés mes amis, où sont mes proches?, oh mes yeux, oh mes nuits\"'),
(29, 29, 'نديك ونعيشو هانين ونطلعوا للقمر ونقول\r\nياليل ياعين', 'Naddik wa anaâichou hanyin ou nattalaâou lakmar wa ankoulou ya lil ya aâyn', 'Je t\'épouserai et on vivra heureux.\r\nOn ira habiter sur la lune et on chantera les belles nuits.'),
(30, 30, 'قال والله نديك باه نولي هــاني هربت من جاني هربت ملهية جاني', 'Kal wallah naddik beh anwalli, hani ahrabt manna djani , ahhrabt alhih  djani', 'Il a juré que je serai sienne, pour vivre heureux, j\'ai essayé de m\'échapper deci delà, il m\'a toujours rattrapé.'),
(31, 31, 'نوضو يانايمين بنات\r\nالسلطان جايـيـن فيهـم واحـدة زينـة الزيين تعشق الحواحب والعيــن ', 'Noudou ya naymin! Abnet assaltan  djayin fihoum wahda zinet azzin taâachek lahwadjeb wa el aâyn', 'Réveillez-vous! Vous qui dormez, les filles du roi arrivent! l\'une d\'elle est une beauté qui aime les beaux yeux et les beaux sourcils'),
(32, 32, 'يابـع المحـاحب ويامقرون الحواجـب ويـن الحبيـب وين الـصـاحب\r\nويـن القلب راه ذاهب', 'Bayeâa lamhadjeb, ou ya magroun lahwadjeb win lahbib, win essaheb win el kalb hahou daheb', 'Oh vendeur de m\'hadjebs, aux sourcils arqués, où est mon bien-aimé, où est mon compagnon? où va mon cœur, où va-t-il ?'),
(33, 33, 'الدنيا ولات صعيبـة وماالصعب تلقـي\r\nحبيبـة جنبـك مع جنبهـا ولي طيح فيها تلقها ذيبـة', ' Addanya wallet assâiba ou mina assaâb talka ahbiba djnbek amâa djanbha wali aytih fiha talkaha diba', 'La vie est devenue dure si bien qu\'il est difficile de trouver la bien-aimée, pour rester l\'un contre l\'autre. Désormais,  quand tu en rencontres une, c\'est une louve'),
(34, 34, 'وينك ياغزالي وينك ياعزالي عودلي واشفق\r\nعلىحالي غيابك عذاب وشوقك ناروالحياة بلابيك ماتحلالي', 'Winek ya ghazali , winek ya ghazali, âoudli wa achfek âala hali , ghiyabek âadeb ou choukek nar  wa el hayet abla bik ma tahla', 'Où es-tu mon bien-aimé ? aies pitié et reviens-moi, ton absence est une souffrance et ton désir une flamme ardente.\r\nLa vie sans toi est amère.'),
(35, 35, 'عذبني وحـرق لـي قلبـي والشكوى لمـن يانـاس الشكـوى لمن\r\nياناس الشكوى غير لربـي', 'Aâddabni wa ahrakli kalbi, wa achakwa limen  ya nass, limen ya nass? ghir el rabbi', 'Il m\'a fait souffrir et m\'a brûlé le cœur, à qui pourrais-je exprimer ma souffrance, à qui ?\r\nSeul le bon dieu peut écouter mes souffrances.'),
(36, 36, 'دايظ علي باب كارنا يرمي في حب الملوك\r\nقالك ياللة مايشريني بوك قلتيلو الحر مايتباع طم الذهب على الذهب وماتكون طماع\r\nقالي نخدم عليك ونصرف الغالي وعلى بنت الرجال نخسر رأس المال', 'Djayez âala beb darna yarmi  fi hab lamlouk  kallek  : \" yalla mayachrini bouk  \",   koltilou : \" el horr ma yatbaâ tamm adhab aâla adhab ou matkoun tammaâ \" kalli : \" nakhdem aâlik ou nassref el ghali,  aâla bent ardjel nakhssar rass el mel', 'Il est passé par chez moi en jetant des cerises, il t\'a dit : \"je jure que ton père ne peut m\'acheter.Tu lui as répondu :\"L\'homme libre ne s\'achète pas !\" \" Épargnes de l\'argent et accumule de l\'or et ne sois pas radin \", il m\'a alors dit : \"je  travaillerai et je dépenserai le plus cher, et pour la fille des plus valeureux des hommes, je dépenserai toute ma richesse.'),
(37, 37, 'بخط\r\nيدو معلم قالي راني بعيد بصح من قلبك راني قريب وان شاء الله مانعود بعيـد سلامـي للحبيب بعثتـو فـي ورق ذهـب كتبتو\r\nوبحروف فضـة رشمـت رد عي السلام مسلم', 'Bi khat yaddou m\'âalem kalli : \"ranni sallemi lahbib abâatou fi awrek adheb aktabtou \" ou bi ahrouf fadda archamt   rad âala esallem moussallem, adâaid bassah min kalbek rani akrib wa in chaa allah ma anaâoud abâaid', 'Le maître m\'a écrit une lettre manuscrite me disant: \"j\'ai envoyé mon message et mes salutations à mon bien-aimé sur une feuille en or, les lettres sont écrites en argent \"à mon tour, j\'ai répondu au message en débutant le message par un grand salut.'),
(38, 38, 'الناس بلحبيــب والناس على الفرحة أتهني\r\nوأنـا الغرام الـي ملكنـي', 'Annass bi lahbib wa annass aâla el farha athanni wa ana laghram amlakni', 'Les gens accompagnés de leur amoureux se félicitent et moi, c\'est l\'amour qui m\'a possédé'),
(39, 39, 'ياقايدن الشموع هاكو ا شمعة قيدوها بالاك\r\nالغايب يعود والفرحة نعاودها', 'Ya kaydin achmouâa hakou chamâa kidouha, balek el ghayeb ayâaoud wa alfarha anaâwdouha', 'Vous qui tenez les chandelles, tenez une bougie, laissez là allumés peut être que l\'absent reviendra et la joie sera au rendez-vous'),
(40, 40, 'ماتعجبك ورقة الدفلة فالغابة دير الضلايل\r\nومايعجبك زين الطفلة حـتـى تشوف الفعايل', 'Matâadjbek  warket addafla fi el ghaba dir adlayell, ou  mayaâadjbek zin  attafla hata atchouf lafaâyel', 'Ne sois pas ébloui par la beauté de la feuille du laurier qui donne de l\'ombre dans une forêt et ne tombe jamais sous le charme d\'une jeune fille avant de voir ses actes'),
(41, 41, 'ياعلي علي يالي أسمك\r\nغالي رجع روحك طبيب ونجي وأجي تشوف حالي نفرشلك فراش حريرونغطيك', 'Ya  ali,   ya  ali   yalli  assmek  ghali,  radjaâa rouhek atbib  wa andji,  ou adji atchouf hali , anfarrachlek  afreche   ahrir wa anghatik  bi izari', 'Oh! toi Ali, ton prénom m\'est cher, sois médecin, je viendrais faire une consultation, et tu prendras conscience de mon état, je viendrais faire ton lit, je te couvrirai avec mon drap qui sera en pure soie'),
(42, 42, 'عمتي ياعمتي واشبيك غضبانة اذا بيك علي\r\nالطعام راني شبعانة واذا بيك على الماء راني رويانة واذابيك على كحل العين مانديه\r\nغير أنــا', 'Aâmti ya âamti wach bik ghadbana? Ida bik aâla atâam, rani chabâana, wa ida bik âala el ma rani rawyana, wa ida bik âala kahl el aâyn manadih ghir ana', 'Tante, tante pourquoi es-tu énervée ? si c\'est à cause de la nourriture je n\'ai plus faim, si c\'est à cause  de l\'eau je n\'ai plus soif et si c\'est à cause de mon bien-aimé aux yeux noirs je ne serai qu\'a lui'),
(43, 43, 'جازو علي 3 بنات يغرس\r\nفالزهر قلت لهم كي ينبت خلولي حقي قالت الولى هذا الزهلر منسوب وقالت الثانية\r\nالزهر مكسوب وقالت الثالثة نشوف المكتوب وأنا عقلي مشا مع المكتوب', 'Djazou âaliya atlata abnet, yagharssou fi azhar, kolt alhom :\" ki yanbet khalouli hakki \" kaletli allawla:\" hada azhar manssoub\",  ou kalet attania  :\" azhar makssoub\", ou kalet attalta :\" anchouf el maktoub\"  wana âakli m\'cha m\'âa el maktoub', 'Trois filles sont passées à côté de moi,  elles plantaient la chance, je leur ai dis :\"quand la chance fleurira laissez-moi ma part\", la première a dit : \"la chance ne nous appartient pas elle est attribuée\", la deuxième  m\'a dit : \"La chance est acquise\" et la troisième m’a dit : \"je verrai le destin\", et c’est alors que mon esprit est allé avec le destin'),
(44, 44, 'ضحكو وضحكت معاهم وكليت ملحهم وبعد يمات\r\nكذبوني شربولي لمرارندمت علي عرفتهم', 'Dahkou, wa adhakt amâahoum, wa aklit wa aklit malhoum, ou baâd ayyamet kadbouni, charbouli  lamrar, andemt aâla  aârafthom', 'Ils ont ri et j\'ai ri avec eux, j\'ai mangé leur pain et après quelques jours ils m\'ont pris pour une monteuse, ils m\'ont fait boire la boisson amère j\'ai regretté de les avoir connus'),
(45, 45, 'قلبي مهموم ملقيت لمن نحكيه حكيتوا لبنات\r\nعايروني بيه', 'Kalbi mahmoum, malkit limen nahkih, ahkitou labnet âayrouni bih', 'Mon cœur est triste, je n\'ai trouvé personne à qui raconter mon histoire, j\'ai fini par raconter aux filles, elles ont divulgué mes secrets'),
(46, 46, 'مشيت مشيت حتى عيت جربت مع مليح والدون\r\nبصح مازال مالقيت اللي يولمني يحمل طبايعي ويديرني امرة في البيت فرج ياربي وابعث\r\nلي الراجل لي تمنيتوا', 'Amchit, amchit hatta aâyit,  djarrabt m\'âa m\'lih wa addouni, bassah mazel malkit alli aywalemni, yahmel atbayâai  wa aydirni amra fi el-bit,  farredj ya rabbi wa abâat li arradjel alli atmanitou', 'J\'ai marché, j\'ai marché...jusqu\'à épuisement, j\'ai essayé avec les bonnes et mauvaises personnes, mais sans pour  autant trouver la personne qui me convienne, qui supporte mon caractère et que de moi sa femme bon dieu aidez-moi à trouver l\'homme que j\'ai tant espéré'),
(47, 47, 'أنا شابة ومهري غالي واللي يبغني يديني\r\nيحسب النجوم ويسهر الليالي ويبنيلي قصور العلالي وايلا بغا الغالي نجبلوا بنات\r\nوالدراري ', 'Ana chabba ou mahri ghali, walli yabghini yaddini yahsseb andjoum ou yasshar elyali ou yabnili akssour lâalali wa illa b\'gha el ghali andjiblou b\'net wa adrari', 'Je suis belle et ma dote est chère et celui qui m\'aime doit savoir compter des palais, et si le bien qui accepte mes conditions je lui donnerais naissance et des filles et des gosses'),
(48, 48, 'جيتكم يالوالدين بجاه\r\nالنبيلا تخلو يطول عذابي أنـا نبغيها وزينها هـو سبابـي', 'Djitkoum ya el waldin, bidjeh anbi latkhalou aytoul aâdabi ana nabghiha ou zinha houwa assbabi', 'Au nom du prophète, parents je vous prie de ne pas faire durer ma souffrance, moi je l\'aime de sa beauté et je ne peux m\'en passer'),
(49, 49, 'اللي جرحلي قلبي ودواه واش مالعين تلقاه نطلب من ربي الفتاح\r\nيخلوني نرتاح ونحل بابي نرتاح', 'Alli adjrahli kalbi daweh, wach mal âayn talkah, natleb man rabbi el fatteh aykhalouni narteh wa anhel babi narteh', 'Celui qui m\'a blessé le cœur,  et l\'a soigné, quels yeux peuvent-ils le voir ? je prie le bon dieu pour qu\'on me  laisse, me reposer, et ouvrir ma porte pour que je sois soulagée'),
(50, 50, 'رديت دفة على دفة وطويت فراشي لفة على\r\nلفة انتا سعدي شمعت لا تطفى', 'Radit daffa âala daffa, wa atwit afrachi laffa âala laffa, anta saâdi chamaâti  la  tatfa', 'J\'ai fermé ma fenêtre, j\'ai plié mon drap plis sur plis, tu es ma chance et ma bougie qui ne s\'éteint pas'),
(51, 51, 'درنـا كبيرة وسورها\r\nعالي الخير ديما فيها دايم يارب ياكريم احفظ ذاك الخيروالنعايم ', 'Darna akbira ou sourha âali, el khir dima fiha dayem, ya rabbi ya akrim, ahfed dek el khir wa anâayem', 'Notre maison est grande ses murs sont hauts,  le bien toujours présent toujours, bon dieu soyez toujours généreux,  protéger notre maison et sauvegardez-nous nos biens et notre richesse'),
(52, 52, 'الناس كسبت الشطب والحطب وأنا كسبت الطير\r\nلمنقارو فضة وريشو ذهب', 'Anness kassbet achteb wana akssebt attir  alli mankarou fadda  ou richou adhab', 'Les gens ont eu les battons et le bois,  et moi j?ai eu l\'?oiseau au bec d\'?argent et au plumes en or'),
(53, 53, 'العقل سواها والدم في العروق دورها وفي\r\nالكبدة فورها وأدها للقلب رسمها وعلى اللسان خرج أسمها', 'Lâakel sawwaha, wa addem fi lâarouk dawwarha , ou fi el kabda fawwarha,  wa addaha lalkalb arssamha,   wa âala elssen akhradj assamha', 'La sagesse l\'a embellit, le sang dans ses veines  l\'a fait tourner,   et dans le foie il s\'évapore  puis le passe au c?ur qui l\'a dessine et sur la langue son nom est prononcé'),
(54, 54, 'ركبـت فوق السبـع\r\nودليــت رجلــي لـي سـاجـي يدنـا ليــا', 'Arkebt fouk assbaâ, ou dallit radjliya, alli sadji yaddana liya', 'Je suis monté sur le dos du lion et j?ai mis de part et d?autre mes pieds,  que celui qui prétend être courageux et à la hauteur vienne s?approcher de moi'),
(55, 55, 'زوج سبوعـة متفاتنين عليـا قالولي مالكي\r\nيابنيةحاجتك بين الحد والاثنين مقضية ', 'Zoudj assbouâa matfatnin aâliya, kalouli:\" malki ya abniya? Hadjtek makdiya bin elhad ou latnin makdiya\"', 'Deux hommes se bagarrent à cause de moi, ils m\'ont dit jeune fille pourquoi es-tu préoccupée?\r\nton vœux sera exaucé entre dimanche et lundi'),
(56, 56, 'كوات\r\nقلبي بالجمر ثلاث بنات يغسلو بالصابون وحدة دايرة\r\nكالشمس والثانية دايرة كالقمر والثالثة  نجمة', 'Akwet kalbi bi el djamra,  atlata abnet yaghasslou bi assaboun, wahda dayra ki achamss, wa attanya dayra ki lakmar, wa attalta nadjma', 'Elle a brûlé mon cœur à la braise, 3 filles se lavaient, la première est comme un soleil, la deuxième est comme la lune et la troisième est une étoile'),
(57, 57, 'خرجت العروسة في يـد وردة الجوهر\r\nوالمرجان حتي لوذنيها حتى بقا و مدهوشين فيها بصح غير اللي يعرف قيمتها اللي يـديها', 'Khardjet lâaroussa, fi yad wardet el djouhar wa el mordjane hatta el wadniha, hatta b\'kaw madhouchin fiha, bassah ghir alli yaâaref kimatha alli yaddiha', 'La mariée est sortie ornée de perles de culture et de corail, tout ceux qui l\'ont vu sont restés bouche bée mais seul celui qui connaîtra sa vraie valeur sera à lui'),
(58, 58, 'زرعت قدام بابكم زريعة القصبر هذي على\r\nبنتكم اذا كانت تصير بنت الحسب والنسب الي فيها نشكر وكلامي عليها ديما كالعسل', 'Azraâat kaddem babkom  zarriâat el kossbor, haddi aâla bantkoum, ida kanet atssir bent lahsseb wa ansseb, alli fiha nachkor wa aklami aâliha dima ki laâssel', 'J\'ai semé prés de votre porte les grains de coriandre, c\'?est pour votre fille qu\'on espère demander, je ne dis que de bonnes choses d\'elle et mes paroles pour elle sont mielleuses et belles'),
(59, 59, 'البير بيرى ويشرب منو غير اللي يبغيني\r\nوالي يعرف قيمتي هو الي يديني', 'El bir biri ou yachrab mannou ghir alli yabghi walli yaâaref kimti houwa alli yaddini', 'Le puits m\'appartient et je ne laisserai boire de mon puits que celui qui m\'aime et je ne serais qu\'a celui qui connaîtra ma valeur'),
(60, 60, 'سيدى الطالب ديرفيا مزيـا جبلي هذاك\r\nالشاب الي مابغاش يخزر فيا أناشابة وزينة بصح زهري دارهابي بيا ', 'Sidi attaleb dir fiya amziya, djibli hadek achbeb alli mayabghich  yakhzor fiya, ana chabba ou zina, bassah zahri dayarha biya ', 'Ya taleb faites-moi plaisir ramènes moi le bel homme qui ne veux pas me regarder, moi je suis jeune et belle mais ma chance m\'a trahit'),
(61, 61, 'سلمت سلامي للزينة في ورق التشينة قلتلها\r\nمازالكي في القلب ديمة', 'Sallemt aslami lazzina fi awrak atchina, koltalha :\" mazalki fi el kalb dima\"', 'J\'ai salué ma belle, en lui écrivant sur la feuille de l\'orange, je lui ai dis :\"tu es toujours dans mon cœur\"'),
(62, 62, 'أسمها مريم وسموها مريومة القلوب منها\r\nمهومة والله ماكان زين كيفها فالحومة أنا نحب مريم ونموت على مريومة ', 'Assamha maryem  wa ayssamouha maryouma, el kouloub manha mahmouma, wallah maken kifha fel houma, ana anhab maryem wa anmout aâla maryouma', 'Elle s\'appelle Meriam et on l\'appelle Maryouma, les cœurs sont tristes de ne pouvoir l\'avoir, je jure qu\'aucune\r\nfille du quartier n\'a sa beauté, moi j\'aime Miriam et je meurs pour Maryouma'),
(63, 63, 'جعلولتي عالية في وسط\r\nالدالية والدالية بالعنب والساقية بالحوت أعطوني بنتكم ولانطيح نموت موت لابغيت\r\nتموت بنتا صدقها غالي 100 حبة لويز و100 حبة سلطاني', 'Djaâalolti âalya, fi wasst addalya, wa addalia bi laâaneb, wa assakya bi el hout, aâatouni bantkom walla antih anmout , anmout, illa abghit bantna assdakha ghali, amyet habbet el wiz ou m\'yet habbet soltani', 'Ma balançoire est haute, elle est au milieu de la dahlia, la dahlia a fait le raisin, les poissons sont dans la rivière donnez moi votre fille sinon je tomberai et je meurt, ses parents lui répondent si tu veux mourir, notre fille sa dote est chère elle vaut 100 pièces de louis et 100 pièces de \"Soltanis\"'),
(64, 64, 'خردت يوم الجمعة في\r\nيدها شمعة قاصد الوالي نطقلي ملاك من السماء قالي روحي يابنتي حاجتك مقضية بربي\r\nوالنبي العربي', 'Fi yadha chamâa kassda el wali, antakli m\'lek mass\'ma kalli:\" rouhi  ya abniya, hadjtek makdiya, bi rabbi wa anbi \" akhredjt youm el djomâa el âar biya', 'Elle tient dans ses mains une bougie, elle dirige vers El-Wali,  un ange m\'a parlé du ciel et m\'a dit : \"va!  ma fille ton souhait est exaucé avec l\'aide du bon dieu et du prophète\", je suis sorite le vendredi à cause de la honte et de l\'ignomnie '),
(65, 65, 'حبطت لقاع البحر ولقيت الرمل يابس بديت\r\nنحفر واندير فالمحابس أنوصيكم يابنات ماتدو غير الريس', 'Ahbet l\'kaâa labhar wa alkit armel yabess, abdit nahfar wa andir fi lamhabess anwassikom ya labnet ma tadou ghir arrayess', 'J\'ai plongé au fond de la mer, j\'ai trouvé le sable sec, je commençais a creuser et a remplir les pots, et conseillé les filles de m\'épouser que le Rais'),
(66, 66, 'القارص مانكلوشنخاف يشيني وشيخ مانخذوش\r\nيالوكان يغنيني نأخذ الشاب', 'El karess manaklouch, ankhaf aychayyani, wa achikh manakhdouch ya \r\nlouken yaghnini, nakhod achbeb  li kadddou aywatini', 'Le citron je ne le mange pas, il me fait maigrir, le vielle homme je ne l\'épouserai pas même s\'il  me  lègue toute sa fortune, je n\'épouserai  que le bel homme qui me convienne '),
(67, 67, 'وردة فالكاس يتخاطفو عليها الناس', 'Warda fi el kess yatkhatfou aâaliha anness', 'Une fleur dans le verre, les gens se bagarrent pour elle'),
(68, 68, 'جزت باب رياض نسرين نادالي الوردة على\r\nالباب والزهر عنقني', 'Djezt beb riad, nassrin nadali,  el warda aâala el beb wa azhar âannakni', 'Je suis passé par la porte de riad il m\'a appelé Nessrine, la fleur est à cote de la porte les roses m\'ont enlacée'),
(69, 69, 'جايز على باب درنا يفصل في العكرى قلتلو\r\nياشاب فصلي على قدي قالي حتى اتجي عندي نفصلك قاط مذهب وزيدلك مالعندي', 'Djayez aâla beb darna ayfassel fi el âakri, koltlou :\"fassali aâla kaddi\" kalli : hatta atdji âandi, anfassalek kat amdahab, wa anzidlek malli âandi', 'Il est passé par la porte de notre maison il découpait un caftan de couleur cannelle, je lui ai dis : \"faites- moi une tenue sur mesure\", il m\'a dit : \"je te ferai un caftan doré et je te rajouterai un autre cadeau\"'),
(70, 70, 'مشي\r\nفي خاطركم في خاطر الشاب لي معاكم 	يالي طالعين للجبل أدوني معاكم', 'Machi fi khatar kom, fi khatar achab alli amâakom, yalli talâayn ladjbel addouni amâakom', 'Ce n\'est pas pour vous mais plutôt pour le jeune homme qui est avec vous, vous qui montez la montagne prenez-moi avec vous'),
(71, 71, 'خرجت بدر البدور طلقت الشعور زادت في\r\nجناني تمنيتها تكون في دارىتدخل وتخرج قدام عدياني', 'Kardjet badr el bodour, talket achâaour, zadet fi adjnani, atmannitha atkoun fi dari tadkhol ou takhrodj kaddem âadyani', 'La plus belle des belles est sortie, elle a lâché ses cheveux et a provoqué ma folie j\'aurai aimé qu\'elle soit dans mon foyer,  elle rentre et elle sort devant mes ennemies'),
(72, 72, 'جارتي ياجارتي قلبي عليك وعيني فيك واش\r\nنعمل واش نواسي اذابوك ماقبل بيا', 'Djarti, ya djarti, kalbi aâalik ou âayni fik, wach naâamel, wach anwassi ida bouk makbel biya?', 'Voisine! Ma voisine,  mon coe?ur est pour toi et mes yeux ne voient que toi, que ferai-je si ton père me refuse ?'),
(73, 73, 'قعدتنا زينة فيها لحباب والنساب والبراني\r\nيقعد زاه قدام الباب', 'Kaâadatna zina, fiha lahbeb wa ansseb, wa el barrani yakâaoud zahi kaddem el beb', 'Notre réunion est conviviale et harmonieuse, elle regroupe les amies et la famille, et l\'étranger reste heureux près de la porte'),
(74, 74, 'بابا بغى لي ولد عمي\r\nويما بغاتلي ولد خالي وأنا قلتلها مانحذشغير لي يوتيني', 'Baba baghili wald âammi, ou yamma wald khali, ana koltelha :\"manakhod ghir  \r\nalli aywatini', 'Mon père veut me faire épouser mon cousin paternel, ma mère préfère le cousin maternel et moi je ne choisirai que celui qui me convienne'),
(75, 75, 'قاعدين في الجنان بين الفل والياسمين\r\nقالي أنا نوتتك حلال ليا يابنية قتلوا اذا كان هكذا روح شوف خاوتي والديا', ' Kaâdin fi ladjnen bin el-fell wa el yassmin, kalli : \"ana anwitek ahlen liya ya labniya\" \r\n koltlou : \"ida ken hakda rouh atchouf khawti ou waldiya\"', 'Il sont assis dans le jardin entre la Moricandia et le jasmin, il m\'a dit : \"moi j\'ai l\'intention de t\'épouser\", je lui ai répondu : \"vas-y voir mes frères et mes parents\"'),
(76, 76, 'يرحم الضعيف ويعاون الزوالي يستحق الشكر\r\nمن كل الأهالي هذا مايكون غير ولد خالي', 'Yarhem adâaif  wa ayâawen azzawali, yassthak achokr man kol al-ahali,  hada maykoun ghir wald khali', 'Il a pitié du faible, et aide le pauvre, il mérite les remerciements de tous les  parents, cet individu ne peut être que moi cousin maternel'),
(77, 77, 'حدودها وردي وشفايفها\r\nعكري وشعرها كحل توت ياناس أحسنو عوني أنا وجهي صفر من مسبوغة لشفار', 'Akhdoudha wardi, wa achfayefha âakri, wa achâarha akhal tout, ya ness ahhassnou âawni wadjhi assfar men massboughet lachfar', 'Ses joues sont roses, ses lèvres sont rouges, et ses cheveux  sont noirs, aidez moi et venez à mon secours, cette  beauté  aux jolis cils a fait blêmir mon visage'),
(78, 78, 'ساس الرملة لا تعاليه ولد الناس لاتربيه', 'Cess arramla la atâalih, wald anness la atrabbih', 'Ne construit pas sur un terrain sableux les fondations ne seront pas solides et n\'éduque pas l\'enfant des autres'),
(79, 79, 'بنتي سومتها غالية وميديها غير راجل ولد\r\nحلالي', 'Banti soumetha ghalya ou mayaddiha ghir radjel wald ahleli', 'La valeur de ma fille est grande et celui qui l\'épouse sera un fils de famille'),
(80, 80, 'قالي نروح للبلاد البعيد ونجيبلك هدية\r\nباش تحني عليا يابتية قتل قلبي مايحنش حتى يشوف بعينيا', 'Kalli :\"anrouh labled abâayd wa andjiblek ahdiya bech athanni aâaliya ya abniya\" kolt :\"kalbi ma ayhanch hatta aychouf bi âayniya', 'Il m\'a dis : \"je partirai dans un pays lointain, je t\'achèterai un cadeau pour que tu sois gentille et tendre avec moi\" je lui ai répondu,  que mon cœur ne sera attendrit que si je voyais de mes propres yeux'),
(81, 81, 'ترجمان ياترجمان ياورد كل اللوان جازوا عليا 3بنات واحدة\r\nرافدة الكابة والثانية ررافدة الكابة ولخرى رافدة حزام وأنا ديت شوشة سيدي فلان', 'Tardjmen, ya tardjmen ya ward kol lalwen, djazou aâliya atlata abnet , wahda rafda el kaba, wa attanya rafda el kaba, ou lokhra rafda ahzem, wana addit chouchet sidi f\'len', 'Interprète, Oh! Interprète, toutes sortes de fleurs sont passé par moi, trois jeunes filles la première portait un cabas, la deuxième portais aussi un cabas et l\'autre tenais une ceinture et moi jai épousé la mèche de monsieur X'),
(82, 82, 'قولو قولو  و القول\r\n     سابق فيكم أنا ديت الخمري  أ 10 في عينكم', 'Koulou, wa el koul sabek fikoum, ana addit el khomri ou âachra fi âaynikom', 'Dites et dites à l\'avance, j\'ai épousé le brun et c\'est celui qui est jaloux en meurt'),
(83, 83, 'سميت سميتو والكبش ضحيتو اذا بغا ربي نعيا في بيتوا', 'Sammit, sammitou, wa el kabch dahitou, ida b\'gha rabbi naâaya fi bitou', 'J\'ai sacrifié un mouton au nom de mon amour, et si le bon dieu le veux je serai la femme de mon bien-aimé'),
(84, 84, 'كان صندوق من\r\n     ذهب تودرولي مفتاحو كل مانتفكر يرفدوني رايحاوا', 'Ken sandouk mad\'hab, atwaddarli maftahou, kol manatfakkar yarafdouni aryahou', 'J\'avais un coffre en or, j\'ai perdu sa clé et des que je me rappelle de lui je suis emportée par son vent'),
(85, 85, 'تـوت ـ تـوت نديك ولا نـمـوت', 'Attout! attout , naddik walla anmout', 'Mure, mure, je t\'épouserais sinon je meurs'),
(86, 86, 'قاعد معاها في التصديرة هو شاب وهي صغيرة\r\nالله يحفظهم مالعين والغيرة', 'Kaâaed m\'âaha fi attassdira, houwa achbeb, ou hiya assghira, allah yahfadkom malâayn wa el ghira', 'C\'est leur mariage ils sont assis sur 2 chaises,  ils sont jeunes puisse le bon dieu les protéger du mauvais œil'),
(87, 87, 'كجلي كحل التوت والليل الياقوت أنا نحبها\r\nوالي يحب يموت يموت', 'Ki djali kahl attout wa allil yakout, ana anhabha walli ayhab aymout aymout', 'Quand mon brun est venu, la nuit était belle au clair de lune, moi je l\'aime et celui qui veux mourir il meurt!'),
(88, 88, 'لوكان نعرف السعود\r\nينغرس بالعود نغرس ستين عود من عودي واذا السعد منك يامسعود ياسقام السعود سقملي\r\nسعدي', 'Louken naâaref assâaoud yanghress bi el âaoud, naghrass satin âaoudmen âaoudi, wa ida assaâad mannek ya massâaoud ya saguem assâaoud, saggamli saâadi', 'Si je savais que la chance se plantait avec une tige, j\'aurais planté 60 tiges et si la chance est de toi,  bon dieu, toi  qui donne la chance,  je vous prie de m\'arranger et me donner ma chance'),
(89, 89, 'الشاب طالع يفطر والعاتق طالعة تنشر\r\nتلاقات العين فالعين والقلب تكسر', 'Acheb talaâa yaftar, wa el âatek talâa tanchar, atlaket el âayn fi el âayn wa el kalb atkassar', 'Le jeune homme monte pour manger et la jeune fille pour étaler le linge, les yeux se sont croisés et le cœur s\'est brisé');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`nom`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `nom`) VALUES
(1, 'chaabi'),
(2, 'fetes'),
(3, 'emissions'),
(4, 'andalou'),
(5, 'interviews'),
(6, 'hawzi'),
(7, 'malouf');

-- --------------------------------------------------------

--
-- Structure de la table `chansons`
--

DROP TABLE IF EXISTS `chansons`;
CREATE TABLE IF NOT EXISTS `chansons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `artiste_id` int NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `audio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie_id` int NOT NULL,
  `views` int NOT NULL DEFAULT '0',
  `likes` int NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`categorie_id`),
  KEY `idx_artiste` (`artiste_id`),
  KEY `idx_chansons_views` (`views`),
  KEY `idx_chansons_created_at` (`created_at`)
) ENGINE=MyISAM AUTO_INCREMENT=422 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `chansons`
--

INSERT INTO `chansons` (`id`, `titre`, `user_id`, `artiste_id`, `image`, `audio`, `categorie_id`, `views`, `likes`, `created_at`) VALUES
(1, 'HIZIYA', 4, 1, 'img_chaabi/abdelhamid ababsa.jpg', 'audio_chaabi/abdelhamid ababsa-hiziya.mp3', 1, 1, 151, '2023-12-03 07:40:36'),
(2, 'Fete', 4, 77, 'img_fetes/chaou & ezzahi.jpg', 'audio_fetes/abdelkader chaou & amar ezzahi-fete.mp3', 2, 45, 152, '2023-12-03 07:40:36'),
(3, 'AAZIZ AALIA', 4, 2, 'img_chaabi/abdelkader chaou_3.jpg', 'audio_chaabi/abdelkader chaou-aaziz aalia.mp3', 1, 49, 152, '2023-12-03 07:40:36'),
(4, 'ACHKI WAGRAMI', 4, 2, 'img_chaabi/abdelkader chaou_1.jpg', 'audio_chaabi/abdelkader chaou-achki wagrami.mp3', 1, 31, 152, '2023-12-03 07:40:36'),
(5, 'CHEHLET LAAYANI', 4, 2, 'img_chaabi/abdelkader chaou_4.jpg', 'audio_chaabi/abdelkader chaou-chehlet laayani.mp3', 1, 32, 152, '2023-12-03 07:40:36'),
(6, 'CHOUFI OUIN HOBEK RMANI', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-choufi ouin hobek rmani.mp3', 1, 30, 152, '2023-12-03 07:40:36'),
(7, 'EL BAHDJA', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-el bahdja.mp3', 1, 30, 150, '2023-12-03 07:40:36'),
(8, 'EL BAZ GHABLI', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-el baz ghabli.mp3', 1, 26, 150, '2023-12-03 07:40:36'),
(9, 'EL KAOUI', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-el kaoui.mp3', 1, 29, 150, '2023-12-03 07:40:36'),
(10, 'ETIR LI WALAFTOU', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-etir li walaftou.mp3', 1, 36, 150, '2023-12-03 07:40:36'),
(11, 'KIF AMALI OUHILTI', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-kif amali ouhilti.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(12, 'MALHABIBI', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-malhabibi.mp3', 1, 25, 150, '2023-12-03 07:40:36'),
(13, 'YA EL HADRA', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-ya el hadra.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(14, 'YADHO AYANI', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-yadho ayani.mp3', 1, 25, 150, '2023-12-03 07:40:36'),
(15, 'YOUM EL DJEMAA', 4, 2, 'img_chaabi/abdelkader chaou.jpg', 'audio_chaabi/abdelkader chaou-youm el djemaa.mp3', 1, 42, 151, '2023-12-03 07:40:36'),
(16, 'EL HAREZ', 4, 3, 'img_chaabi/abdelkader chercham.png', 'audio_chaabi/abdelkader chercham-el harez.mp3', 1, 47, 151, '2023-12-03 07:40:36'),
(17, 'NAOUI NTOUB', 4, 3, 'img_chaabi/abdelkader chercham.png', 'audio_chaabi/abdelkader chercham-naoui ntoub.mp3', 1, 25, 150, '2023-12-03 07:40:36'),
(18, 'SAHALI', 4, 3, 'img_chaabi/abdelkader chercham.png', 'audio_chaabi/abdelkader chercham-sahali.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(19, 'EL HANA', 4, 4, 'img_chaabi/abdelkader guessoum.jpg', 'audio_chaabi/abdelkader guessoum-el hana.mp3', 1, 25, 150, '2023-12-03 07:40:36'),
(20, 'FETE 1', 4, 78, 'img_fetes/abdellah guettaf.png', 'audio_fetes/abdellah guettaf-fete 1.mp3', 2, 26, 150, '2023-12-03 07:40:36'),
(21, 'FETE 2', 4, 78, 'img_fetes/abdellah guettaf.png', 'audio_fetes/abdellah guettaf-fete 2.mp3', 2, 25, 150, '2023-12-03 07:40:36'),
(22, 'FETE 3', 4, 78, 'img_fetes/abdellah guettaf.png', 'audio_fetes/abdellah guettaf-fete 3.mp3', 2, 27, 150, '2023-12-03 07:40:36'),
(23, 'EL ASSIMA', 4, 5, 'img_chaabi/abdelmadjid meskoud.jpg', 'audio_chaabi/abdelmadjid meskoud-el assima.mp3', 1, 26, 150, '2023-12-03 07:40:36'),
(24, 'QISSAT ALGHOULAM', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imansourane-qissat alghoulam.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(25, 'RACHDA', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imansourane-rachda.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(26, 'EL WAHCHE AALIYA & BARANI GHRIB', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imansouren-el wahche aaliya & barani ghrib.mp3', 1, 26, 150, '2023-12-03 07:40:36'),
(27, 'En live', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imansouren-en live.mp3', 1, 29, 150, '2023-12-03 07:40:36'),
(28, 'QISSATE ECHAHID', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imansouren-qissate echahid.mp3', 1, 25, 150, '2023-12-03 07:40:36'),
(29, 'RAH ELGHALI', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imansouren-rah elghali.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(30, 'KISAT EL MOUMEN WEL KAFER_1', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imensouren - kisat el moumen wel kafer_1.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(31, 'KISAT EL MOUMEN WEL KAFER _2', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imensouren -kisat el moumen wel kafer _2.mp3', 1, 27, 150, '2023-12-03 07:40:36'),
(32, 'Abdelmalek Imensouren', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imensouren-abdelmalek imensouren.mp3', 1, 35, 151, '2023-12-03 07:40:36'),
(33, 'KISSET SIDNA YAKOUB & SIDNA YOUCEF', 4, 6, 'img_fetes/abdelmalek imansourane.jpg', 'audio_fetes/abdelmalek imensouren-kisset sidna yakoub & sidna youcef.mp3', 2, 30, 150, '2023-12-03 07:40:36'),
(34, 'KISSET SIDNA YOUCEF', 4, 6, 'img_chaabi/abdelmalek imansourane.jpg', 'audio_chaabi/abdelmalek imensouren-kisset sidna youcef.mp3', 1, 28, 150, '2023-12-03 07:40:36'),
(35, 'DAR EL SULTAN', 4, 7, 'img_chaabi/abdelrezak bougataya.jpg', 'audio_chaabi/abdelrezak bougataya-dar el sultan.mp3', 1, 31, 150, '2023-12-03 07:40:37'),
(36, 'ELWAFATE ELRASSOUL', 4, 8, 'img_chaabi/abderahmane elkoubi_scen.jpg', 'audio_chaabi/abderahmane elkoubi-elwafate elrassoul.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(37, 'YA TALEB TIRI', 4, 8, 'img_chaabi/abderahmane elkoubi_scen.jpg', 'audio_chaabi/abderahmane elkoubi-ya taleb tiri.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(38, 'DEKHLE LE RIYAD', 4, 9, 'img_chaabi/alice fitoussi.jpg', 'audio_chaabi/alice fitoussi-dekhle le riyad.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(39, 'LE FETIMA', 4, 9, 'img_chaabi/alice fitoussi.jpg', 'audio_chaabi/alice fitoussi-le fetima.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(40, 'NAKKAR LAHSSAN', 4, 10, 'img_chaabi/amar el achab.jpg', 'audio_chaabi/amar elachab-nakkar lahssan.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(41, 'NASTAHAL ELKIYA', 4, 10, 'img_chaabi/amar el achab.jpg', 'audio_chaabi/amar elachab-nastahal elkiya.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(42, 'RABI BLEK', 4, 10, 'img_chaabi/amar el achab.jpg', 'audio_chaabi/amar elachab-rabi blek.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(43, 'ACHIAHATOUN', 4, 10, 'img_chaabi/amar elhachab.jpg', 'audio_chaabi/amar elhachab-achiahatoun.mp3', 1, 33, 150, '2023-12-03 07:40:37'),
(44, 'ACHKI WARHAMI', 4, 10, 'img_chaabi/amar elhachab.jpg', 'audio_chaabi/amar elhachab-achki warhami.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(45, 'MACHI GHIR ENTA', 4, 10, 'img_chaabi/amar elhachab.jpg', 'audio_chaabi/amar elhachab-machi ghir enta.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(46, 'YAKHAY RAH', 4, 10, 'img_chaabi/amar elhachab.jpg', 'audio_chaabi/amar elhachab-yakhay rah.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(47, 'FETE 1_3', 4, 11, 'img_fetes/ezzahi & elkoubi.jpg', 'audio_fetes/amar ezzahi & el koubi-fete 1_3.mp3', 2, 26, 150, '2023-12-03 07:40:37'),
(48, 'FETE 2_3', 4, 11, 'img_fetes/ezzahi & elkoubi.jpg', 'audio_fetes/amar ezzahi & el koubi-fete 2_3.mp3', 2, 27, 150, '2023-12-03 07:40:37'),
(49, 'FETE 3_3', 4, 11, 'img_fetes/ezzahi & elkoubi.jpg', 'audio_fetes/amar ezzahi & el koubi-fete 3_3.mp3', 2, 26, 150, '2023-12-03 07:40:37'),
(50, 'EL HARRAZ', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi- el harraz.mp3', 1, 31, 153, '2023-12-03 07:40:37'),
(51, 'ALIK EL HANA', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-alik el hana.mp3', 1, 29, 150, '2023-12-03 07:40:37'),
(52, 'DJANI BACHAR', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-djani bachar.mp3', 1, 32, 150, '2023-12-03 07:40:37'),
(53, 'EL KHAZNA ESHRIRA', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-el khazna eshrira.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(54, 'EL MAKNIN', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-el maknin.mp3', 1, 31, 150, '2023-12-03 07:40:37'),
(55, 'HAD EL KHATAM', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-had el khatam.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(56, 'ROUHI WARAHTI', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-rouhi warahti.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(57, 'Soltane El ber ou El bhar Sidi Sahnoun', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-soltane el ber ou el bhar sidi sahnoun.mp3', 1, 36, 151, '2023-12-03 07:40:37'),
(58, 'YA MERIOUMA', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-ya meriouma.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(59, 'YADIF ALLAH', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-yadif allah.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(60, 'ZINOUBA', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-zinouba.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(61, 'allef kiya', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-allef kiya.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(62, 'hadjou lefkar', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-hadjou lefkar.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(63, 'mali hadja', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-mali hadja.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(64, 'qaada vrais khelouia', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-qaada vrais khelouia.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(65, 'yamali', 4, 11, 'img_chaabi/amar ezzahi.jpg', 'audio_chaabi/amar ezzahi-yamali.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(66, 'SABHAN ALLAH YALTIF', 4, 12, 'img_chaabi/amina zoheir.jpg', 'audio_chaabi/amina zoheir-sabhan allah yaltif.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(67, 'ADJI NSBLEK', 4, 12, 'img_chaabi/amina zouheir.jpg', 'audio_chaabi/amina zouheir-adji nsblek.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(68, 'EL HANA', 4, 13, 'img_chaabi/aziouz rais & hassiba.jpg', 'audio_chaabi/aziouz rais & hassiba-el hana.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(69, 'ALIK EL HANA', 4, 14, 'img_chaabi/aziouz rais.jpg', 'audio_chaabi/aziouz rais-alik el hana.mp3', 1, 29, 151, '2023-12-03 07:40:37'),
(70, 'AZIZ ALIYA MKHILES', 4, 14, 'img_chaabi/aziouz rais.jpg', 'audio_chaabi/aziouz rais-aziz aliya mkhiles.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(71, 'LALA RHANIA', 4, 14, 'img_chaabi/aziouz rais.jpg', 'audio_chaabi/aziouz rais-lala rhania.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(72, 'YAFARHI DJAT', 4, 14, 'img_chaabi/aziouz rais.jpg', 'audio_chaabi/aziouz rais-yafarhi djat.mp3', 1, 26, 150, '2023-12-03 07:40:37'),
(73, 'DERDJ RAML', 4, 15, 'img_andalou/bestani bilel.jpg', 'audio_andalou/bestani bilel-derdj raml.mp3', 4, 30, 151, '2023-12-03 07:40:37'),
(74, 'SARA', 4, 16, 'img_chaabi/abdelkrim bouaziz.jpg', 'audio_chaabi/bouaziz-sara.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(75, 'ACHHAL BKAT FATMA', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-achhal bkat fatma.mp3', 1, 30, 151, '2023-12-03 07:40:37'),
(76, 'ANA ELKAOUI', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-ana elkaoui.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(77, 'CHHAL BKAT FATMA', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-chhal bkat fatma.mp3', 1, 25, 150, '2023-12-03 07:40:37'),
(78, 'EL OUFAT_1', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-el oufat_1.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(79, 'EL OUFAT_2', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-el oufat_2.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(80, 'ELKAOUI YALGHAFEL', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-elkaoui yalghafel.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(81, 'NOUWREK', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-nouwrek.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(82, 'RAH YANDAM', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-rah yandam.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(83, 'SLAT ALAA MOHAMED', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-slat alaa mohamed.mp3', 1, 28, 151, '2023-12-03 07:40:38'),
(84, 'YA EL GHALI', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-ya el ghali.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(85, 'YARASSI NOUSSIK', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-yarassi noussik.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(86, 'YOUM EL DJEMAA', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-youm el djemaa.mp3', 1, 28, 152, '2023-12-03 07:40:38'),
(87, 'ZEWEDNA FI HMAK', 4, 17, 'img_chaabi/boudjemaa elankis.jpg', 'audio_chaabi/boudjemaa elankis-zewedna fi hmak.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(88, 'JINGLE CHAABI', 4, 18, 'img_chaabi/chaabi dialna.png', 'audio_chaabi/chaabi dialna-jingle chaabi.mp3', 1, 26, 152, '2023-12-03 07:40:38'),
(89, 'WALFI MERIAM', 4, 19, 'img_chaabi/cheikh ghaffour.jpg', 'audio_chaabi/cheikh ghafour-walfi meriam.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(90, 'ZAMANE EL KADAR', 4, 19, 'img_chaabi/cheikh ghaffour.jpg', 'audio_chaabi/cheikh ghafour-zamane el kadar.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(91, 'ELI FAT MAT', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-eli fat mat.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(92, 'KHABI SERREK YALGHAFEL', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-khabi serrek yalghafel.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(93, 'YA QLIL ELKHIR', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-ya qlil elkhir.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(94, 'YA RAYEH', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-ya rayeh.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(95, 'YAL GHAFEL', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-yal ghafel.mp3', 1, 25, 150, '2023-12-03 07:40:38'),
(96, 'YAL HADJLA', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-yal hadjla.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(97, 'ZOUDJ HMAMATE', 4, 20, 'img_chaabi/dahmane el harrachi.jpg', 'audio_chaabi/dahmane el harrachi-zoudj hmamate.mp3', 1, 45, 150, '2023-12-03 07:40:38'),
(98, 'MADOUM EHIKMA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachemi guerouabi-madoum ehikma.mp3', 1, 27, 150, '2023-12-03 07:40:38'),
(99, 'YA KHALEK LECHIEA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachemi guerouabi-ya khalek lechiea.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(100, 'AACHKI FI KHNATHA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-aachki fi khnatha.mp3', 1, 29, 151, '2023-12-03 07:40:38'),
(101, 'ABOUYA HNINI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-abouya hnini.mp3', 1, 37, 150, '2023-12-03 07:40:38'),
(102, 'ALLO', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-allo.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(103, 'ANA BELLAH OUECHRAA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ana bellah ouechraa.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(104, 'AZIZ ALIYA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-aziz aliya.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(105, 'BELLAGH SLAMI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-bellagh slami.mp3', 1, 29, 151, '2023-12-03 07:40:38'),
(106, 'DJATE ECHTA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-djate echta.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(107, 'EL BAHDJA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-el bahdja.mp3', 1, 27, 150, '2023-12-03 07:40:38'),
(108, 'EL BARAH', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-el barah.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(109, 'EL HAREZ  YAMNA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-el harez  yamna.mp3', 1, 26, 150, '2023-12-03 07:40:38'),
(110, 'EL HARRAZ', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-el harraz.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(111, 'GHALAT FI HSABEK', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ghalat fi hsabek.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(112, 'HAKMET', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-hakmet.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(113, 'Hadjou lefkar', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-hadjou lefkar.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(114, 'KEF MLAMEK', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-kef mlamek.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(115, 'KIF AMALI OUHILTI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-kif amali ouhilti.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(116, 'KOULOU LIYAMNA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-koulou liyamna.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(117, 'LAKITOU HABIBI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-lakitou habibi.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(118, 'LEBLA FELKHOULTA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-lebla felkhoulta.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(119, 'LERIEM', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-leriem.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(120, 'MAGOINI SAHRAN', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-magoini sahran.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(121, 'MEHANTI QUAT', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-mehanti quat.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(122, 'NSEBLEK YAOUMRI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-nseblek yaoumri.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(123, 'ROUF ADABEL LAAYAN', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-rouf adabel laayan.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(124, 'SALEM YA MELEM', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-salem ya melem.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(125, 'SBAYETTE ZOUDJ', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-sbayette zoudj.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(126, 'TOUCHIAT MAYA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-touchiat maya.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(127, 'WAHDANI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-wahdani.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(128, 'YA BNEL OUERCHAN', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ya bnel ouerchan.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(129, 'YA KHALEK LECHIEA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ya khalek lechiea.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(130, 'YA MENTRID QTALI', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ya mentrid qtali.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(131, 'YA MOULAY YALLAH', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ya moulay yallah.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(132, 'YA TALEB', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-ya taleb.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(133, 'YAALI CHOUFFE', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-yaali chouffe.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(134, 'YABNEL OUERCHAN', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-yabnel ouerchan.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(135, 'YAL ELWARKA', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-yal elwarka.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(136, 'YATALEB', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-yataleb.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(137, 'YOUM ELKHEMIS', 4, 21, 'img_chaabi/el hachmi guerouabi.jpg', 'audio_chaabi/el hachmi guerouabi-youm elkhemis.mp3', 1, 30, 151, '2023-12-03 07:40:39'),
(138, 'Fete 15 touchia grib rare', 4, 22, 'img_fetes/el hadj el anka_4.jpg', 'audio_fetes/el hadj el anka -fete 15 touchia grib rare.mp3', 2, 29, 150, '2023-12-03 07:40:39'),
(139, '24 DISQUES DOUNIA RARES', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-24 disques dounia rares.mp3', 1, 42, 152, '2023-12-03 07:40:39'),
(140, 'AACHKI FIKHNATA', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-aachki fikhnata.mp3', 1, 44, 151, '2023-12-03 07:40:39'),
(141, 'BE AYI SABEB NAHDJER', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-be ayi sabeb nahdjer.mp3', 1, 27, 150, '2023-12-03 07:40:39'),
(142, 'EL BAZ RHABLI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-el baz rhabli.mp3', 1, 29, 151, '2023-12-03 07:40:39'),
(143, 'EL HAMDOU LILLAH', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-el hamdou lillah.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(144, 'EL MAROKI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-el maroki.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(145, 'EL MEKNASSIA', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-el meknassia.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(146, 'GOUMRIETE LABROUDJ', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-goumriete labroudj.mp3', 1, 28, 150, '2023-12-03 07:40:39'),
(147, 'Ghadder kassek ya ndim', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-ghadder kassek ya ndim.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(148, 'HAJOU LEBKAR', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-hajou lebkar.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(149, 'Hadjou men el fikr chwaqi', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-hadjou men el fikr chwaqi.mp3', 1, 27, 150, '2023-12-03 07:40:39'),
(150, 'INKOUNTA ACHIQ', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-inkounta achiq.mp3', 1, 27, 150, '2023-12-03 07:40:39'),
(151, 'KOUM YAMAACHOUKI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-koum yamaachouki.mp3', 1, 26, 150, '2023-12-03 07:40:39'),
(152, 'LAHMAME', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-lahmame.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(153, 'LALA FATIMA  annee 50', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-lala fatima  annee 50.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(154, 'LALA FATIMA CHEZ KAMEL FARDJ ALAH', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-lala fatima chez kamel fardj alah.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(155, 'MAL JAFNI MALKALBI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-mal jafni malkalbi.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(156, 'MANDOZA', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-mandoza.mp3', 1, 25, 150, '2023-12-03 07:40:39'),
(157, 'MAY CHALI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-may chali.mp3', 1, 28, 150, '2023-12-03 07:40:40'),
(158, 'MERSOUL FATMA', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-mersoul fatma.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(159, 'MOSTAGANEM 1970', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-mostaganem 1970 .mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(160, 'NADJMET DOUJA AASASE', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-nadjmet douja aasase.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(161, 'NAR LAHWA KDATE FIKALBI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-nar lahwa kdate fikalbi.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(162, 'OUINE SAADI', 4, 22, 'img_chaabi/el_hadj_elanka.png', 'audio_chaabi/el hadj el anka-ouine saadi.mp3', 1, 150, 150, '2023-12-03 07:40:40'),
(163, 'OULFI MERIAM_1', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-oulfi meriam_1.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(164, 'OULFI MERIAM_2', 4, 22, 'img_chaabi/el_hadj_el_anka_2.jpeg', 'audio_chaabi/el hadj el anka-oulfi meriam_2.mp3', 1, 151, 151, '2023-12-03 07:40:40'),
(165, 'QOULO LYAMIN', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-qoulo lyamin.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(166, 'RANA DJINEK', 4, 22, 'img_chaabi/el hadj el anka_5.jpg', 'audio_chaabi/el hadj el anka-rana djinek.mp3', 1, 53, 154, '2023-12-03 07:40:40'),
(167, 'REBIAIYA_1', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-rebiaiya_1.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(168, 'REBIAIYA_2', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-rebiaiya_2.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(169, 'SABHAN ALLAH', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-sabhan allah.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(170, 'SABHAN ALLAH_1', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-sabhan allah_1.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(171, 'SABHAN ALLAH_2', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-sabhan allah_2.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(172, 'TOUCHIA', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-touchia.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(173, 'YA MOHAMED YASSIDI', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-ya mohamed yassidi.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(174, 'YA SIDI YARESSOL', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-ya sidi yaressol.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(175, 'YA SOLTANE ELMLAH', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-ya soltane elmlah.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(176, 'YALLI MATADER FELHOB', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-yalli matader felhob.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(177, 'YAMALIK ELMOULOUK', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-yamalik elmoulouk.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(178, 'Youm El Djemaa', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-youm el djemaa.mp3', 1, 57, 155, '2023-12-03 07:40:40'),
(179, 'Zora & Maychali', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-zora & maychali.mp3', 1, 32, 152, '2023-12-03 07:40:40'),
(180, 'anciennes chansons', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-anciennes chansons-2.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(181, 'chansons anciennes', 4, 22, 'img_chaabi/el hadj el anka.jpg', 'audio_chaabi/el hadj el anka-chansons anciennes-1.mp3', 1, 27, 150, '2023-12-03 07:40:40'),
(182, 'GOULILI BILAH YA CHEMAA', 4, 23, 'img_chaabi/el hadj mahfoud.jpg', 'audio_chaabi/el hadj mahfoud-goulili bilah ya chemaa.mp3', 1, 30, 151, '2023-12-03 07:40:40'),
(183, 'MALHBIBI MALOU', 4, 23, 'img_chaabi/el hadj mahfoud.jpg', 'audio_chaabi/el hadj mahfoud-malhbibi malou.mp3', 1, 27, 150, '2023-12-03 07:40:40'),
(184, '1959 Roufi Bel Ouessoul', 4, 24, 'img_chaabi/el hadj menouar.png', 'audio_chaabi/el hadj menouar-1959 roufi bel ouessoul.mp3', 1, 38, 150, '2023-12-03 07:40:40'),
(185, 'CHAABI', 4, 24, 'img_chaabi/el hadj menouar.png', 'audio_chaabi/el hadj menouar-chaabi.mp3', 1, 26, 151, '2023-12-03 07:40:40'),
(186, 'EN PUBLIC AVEC GUERROUABI', 4, 24, 'img_chaabi/el hadj menouar.png', 'audio_chaabi/el hadj menouar-en public avec guerrouabi.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(187, 'ZORA YA ACHKLNE ZORA', 4, 24, 'img_chaabi/el hadj menouar.png', 'audio_chaabi/el hadj menouar-zora ya achklne zora.mp3', 1, 32, 150, '2023-12-03 07:40:40'),
(188, 'ALA RSOUL EL HADI', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-ala rsoul el hadi.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(189, 'EL QAHOUA OUEL LATAY', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-el qahoua ouel latay.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(190, 'ELBLA FEL KHOLTA', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-elbla fel kholta.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(191, 'KIFACH HILTI', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-kifach hilti.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(192, 'NAOUI NCHALLAH NTOUB', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-naoui nchallah ntoub.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(193, 'YA RABBI SAHALLI', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-ya rabbi sahalli.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(194, 'YAL QADI', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-yal qadi.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(195, 'YALI TEHAB TAHMAL SPORT', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-yali tehab tahmal sport.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(196, 'YOUM EL DJEMA', 4, 25, 'img_chaabi/el hadj mrizek.jpg', 'audio_chaabi/el hadj mrizek-youm el djema.mp3', 1, 30, 150, '2023-12-03 07:40:40'),
(197, 'DOUR BIHA', 4, 26, 'img_chaabi/emir nacer.jpg', 'audio_chaabi/emir nacer-dour biha.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(198, 'ELKHILAHA', 4, 27, 'img_chaabi/esma djermoune.png', 'audio_chaabi/esma djermoune-elkhilaha.mp3', 1, 27, 150, '2023-12-03 07:40:40'),
(199, 'MAZELNI MAAK', 4, 27, 'img_chaabi/esma djermoune.png', 'audio_chaabi/esma djermoune-mazelni maak.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(200, 'MENHO LI BLEK', 4, 27, 'img_chaabi/esma djermoune.png', 'audio_chaabi/esma djermoune-menho li blek.mp3', 1, 27, 150, '2023-12-03 07:40:40'),
(201, 'MERYOUMA', 4, 27, 'img_chaabi/esma djermoune.png', 'audio_chaabi/esma djermoune-meryouma.mp3', 1, 33, 151, '2023-12-03 07:40:40'),
(202, 'YA NASS DJARATLI', 4, 27, 'img_chaabi/esma djermoune.png', 'audio_chaabi/esma djermoune-ya nass djaratli.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(203, 'AHYA MACHTA', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-ahya machta.mp3', 1, 27, 150, '2023-12-03 07:40:40'),
(204, 'ANA RABI KADAALIA', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-ana rabi kadaalia.mp3', 1, 28, 150, '2023-12-03 07:40:40'),
(205, 'ANA TOUIRI', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-ana touiri.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(206, 'KALB BATSALI', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-kalb batsali.mp3', 1, 27, 150, '2023-12-03 07:40:40'),
(207, 'MAL HABIBI MALOU', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-mal habibi malou.mp3', 1, 150, 150, '2023-12-03 07:40:40'),
(208, 'YA BELLAREDJ', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-ya bellaredj.mp3', 1, 150, 150, '2023-12-03 07:40:40'),
(209, 'YADRA YARABI', 4, 28, 'img_chaabi/fadila_dziria-1.jpg', 'audio_chaabi/fadila dziria-yadra yarabi.mp3', 1, 151, 150, '2023-12-03 07:40:40'),
(210, 'Hada Aam El Kheir', 4, 29, 'img_chaabi/faycal hedroug.jpg', 'audio_chaabi/faycal hedroug-hada aam el kheir.mp3', 1, 26, 150, '2023-12-03 07:40:40'),
(211, 'Mersoul Fatma Ya Nari', 4, 29, 'img_chaabi/faycal hedroug.jpg', 'audio_chaabi/faycal hedroug-mersoul fatma ya nari.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(212, 'Ya Rahet El Aaqel', 4, 29, 'img_chaabi/faycal hedroug.jpg', 'audio_chaabi/faycal hedroug-ya rahet el aaqel.mp3', 1, 25, 150, '2023-12-03 07:40:40'),
(213, 'YaRabi Bhali Tadri', 4, 29, 'img_chaabi/faycal hedroug.jpg', 'audio_chaabi/faycal hedroug-yarabi bhali tadri.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(214, 'NESTEHAL ELKIYA', 4, 30, 'img_chaabi/fella ababsa.jpg', 'audio_chaabi/fella ababsa-nestehal elkiya.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(215, 'MOUL ECHACHE', 4, 31, 'img_chaabi/fella sghera.jpg', 'audio_chaabi/fella sghera-moul echache.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(216, 'BETAIHI RAML', 4, 32, 'img_andalou/webc.jpg', 'audio_andalou/hamani kenga-betaihi raml.mp3', 4, 26, 150, '2023-12-03 07:40:41'),
(217, 'EL WALDINE', 4, 33, 'img_chaabi/hamid abdjaoui.jpg', 'audio_chaabi/hamid abdjaoui-el waldine.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(218, 'LEDJNAS EZRANE', 4, 33, 'img_chaabi/hamid abdjaoui.jpg', 'audio_chaabi/hamid abdjaoui-ledjnas ezrane.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(219, 'BAHR ETTOFANE', 4, 34, 'img_chaabi/hassen elkaoune.png', 'audio_chaabi/hassen elkaoune-bahr ettofane.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(220, 'GOUMRIYATE LABROUDJ', 4, 34, 'img_chaabi/hassen_elkaoune.png', 'audio_chaabi/hassen elkaoune-goumriyate labroudj.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(221, 'RABI AAL MLIH IDABAR', 4, 34, 'img_chaabi/hassen_elkaoune.png', 'audio_chaabi/hassen elkaoune-rabi aal mlih idabar.mp3', 1, 151, 150, '2023-12-03 07:40:41'),
(222, 'SIFTECHEMAA', 4, 35, 'img_chaabi/hassen said.jpg', 'audio_chaabi/hassen said-siftechemaa.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(223, 'ANTA SAYAD', 4, 36, 'img_chaabi/kamel belkhiret.png', 'audio_chaabi/kamel belkhiret-anta sayad.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(224, 'KOUN LI OUNIS YA MOHAMED', 4, 36, 'img_chaabi/kamel belkhiret.png', 'audio_chaabi/kamel belkhiret-koun li ounis ya mohamed.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(225, 'YA AROUSSE EL DJANA', 4, 36, 'img_chaabi/kamel belkhiret.png', 'audio_chaabi/kamel belkhiret-ya arousse el djana.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(226, 'A Masbah AZINE  Ain Taya Avril 2013', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-a masbah azine  ain taya avril 2013.mp3', 1, 71, 153, '2023-12-03 07:40:41'),
(227, 'ANA EL KAOUI', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-ana el kaoui.mp3', 1, 28, 150, '2023-12-03 07:40:41'),
(228, 'ATFAKAR EL MOUT WEL KBAR YA INSANI', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-atfakar el mout wel kbar ya insani.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(229, 'BAINEM LE 05 04 2016', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-bainem le 05 04 2016.mp3', 2, 28, 150, '2023-12-03 07:40:41'),
(230, 'BEST OF', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-best of.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(231, 'ECHEMAA YA AKHINA ALTAF BINA YALHALI', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-echemaa ya akhina altaf bina yalhali.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(232, 'EL KAHWA WE LATAY', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-el kahwa we latay.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(233, 'EL KHEZNA LKBIRA', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-el khezna lkbira.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(234, 'EL MOUT TABHAETNI EL BLA FELKHOLTA', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-el mout tabhaetni el bla felkholta.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(235, 'ELTOF BINA YA HADI', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-eltof bina ya hadi.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(236, 'FETE ANNABA REJLI MECHET BYA OUSEBTI AAYNI le  22 04 2011', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-fete annaba rejli mechet bya ousebti aayni le  22 04 2011.mp3', 2, 33, 151, '2023-12-03 07:40:41'),
(237, 'FETE KHEDMA 2011', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-fete khedma 2011.mp3', 2, 27, 150, '2023-12-03 07:40:41'),
(238, 'FIK RAHOUM', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-fik rahoum.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(239, 'FIK RHAHOUM RARTADJAW', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-fik rhahoum rartadjaw.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(240, 'Fete 2008', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-fete 2008.mp3', 2, 25, 150, '2023-12-03 07:40:41'),
(241, 'HADJOU LFKAR', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-hadjou lfkar.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(242, 'KOUM ARBAHTACHE', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-koum arbahtache.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(243, 'MAY CHALI', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-may chali.mp3', 1, 26, 150, '2023-12-03 07:40:41'),
(244, 'RACHDA', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-rachda.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(245, 'Ramadhan 2013  Blida.', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-ramadhan 2013  blida..mp3', 2, 26, 150, '2023-12-03 07:40:41'),
(246, 'SOIREE COMPLETE A ALGER PLAGE le 19 09 2013', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-soiree complete a alger plage le 19 09 2013.mp3', 2, 25, 150, '2023-12-03 07:40:41'),
(247, 'SOIREE COMPLETE A KOUBA MARIAGE DE SAMIR NOURINE le 12 05 2016', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-soiree complete a kouba mariage de samir nourine le 12 05 2016.mp3', 2, 28, 150, '2023-12-03 07:40:41'),
(248, 'SOIREE COMPLETE A OULED EL ARBI BOUMERDES le 13', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-soiree complete a ouled el arbi boumerdes le 13-07-2017.mp3', 2, 25, 150, '2023-12-03 07:40:41'),
(249, 'YA AHL ZINE EL FASI', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-ya ahl zine el fasi.mp3', 1, 27, 150, '2023-12-03 07:40:41'),
(250, 'YA NAS DJARATLI GHARAYAB', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-ya nas djaratli gharayab.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(251, 'YAL MOKHTAR', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-yal mokhtar.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(252, 'Ya Chafi', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-ya chafi.mp3', 1, 25, 150, '2023-12-03 07:40:41'),
(253, 'el wahdani', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-el wahdani.mp3', 1, 28, 150, '2023-12-03 07:40:42'),
(254, 'fete 2010', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-fete 2010.mp3', 2, 26, 150, '2023-12-03 07:40:42'),
(255, 'fete', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-fete.mp3', 2, 28, 150, '2023-12-03 07:40:42'),
(256, 'fetes1966', 4, 37, 'img_fetes/kamel bourdib.jpg', 'audio_fetes/kamel bourdib-fetes1966.mp3', 2, 25, 150, '2023-12-03 07:40:42'),
(257, 'hommage a zerrouk daghefali (SIDI ALI MBARAK ) kolea', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-hommage a zerrouk daghefali (sidi ali mbarak ) kolea.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(258, 'wassiya complete  1', 4, 37, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-wassiya complete  1-2.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(259, 'ya el mokhtar 3', 4, 38, 'img_chaabi/kamel bourdib.jpg', 'audio_chaabi/kamel bourdib-ya el mokhtar 3-5.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(260, 'ADJINI', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-adjini.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(261, 'AGHEDAR', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-aghedar.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(262, 'CHEMAA', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-chemaa.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(263, 'LAHNINA', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-lahnina.mp3', 1, 25, 1, '2023-12-03 07:40:42'),
(264, 'LEFRAQ', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-lefraq.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(265, 'YA DANYA', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-ya danya.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(266, 'YA DZAYER', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messaoudi-ya dzayer.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(267, 'ANA OUNTI YAGUITARA', 4, 38, 'img_chaabi/kamel messaoudi.jpg', 'audio_chaabi/kamel messouadi-ana ounti yaguitara.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(268, 'DLIBLA ZIDANE', 4, 39, 'img_andalou/kateb naguib.jpg', 'audio_andalou/kateb naguib-dlibla zidane.mp3', 4, 27, 151, '2023-12-03 07:40:42'),
(269, 'MCEDDER RAML', 4, 39, 'img_andalou/kateb naguib.jpg', 'audio_andalou/kateb naguib-mcedder raml.mp3', 4, 25, 150, '2023-12-03 07:40:42'),
(270, 'CHAHR EL AOUACHIR', 4, 40, 'img_andalou/la corale.jpg', 'audio_andalou/la corale-chahr el aouachir.mp3', 4, 26, 150, '2023-12-03 07:40:42'),
(271, 'DERDJ MALLOUF ZIDANE', 4, 40, 'img_andalou/la corale.jpg', 'audio_andalou/la corale-derdj mallouf zidane.mp3', 4, 26, 150, '2023-12-03 07:40:42'),
(272, 'INSIRAF KHLASS RAML', 4, 40, 'img_andalou/la corale.jpg', 'audio_andalou/la corale-insiraf khlass raml.mp3', 4, 25, 150, '2023-12-03 07:40:42'),
(273, 'KADRIA ZIDANE', 4, 40, 'img_andalou/la corale.jpg', 'audio_andalou/la corale-kadria zidane.mp3', 4, 27, 150, '2023-12-03 07:40:42'),
(274, 'EZHIRO', 4, 41, 'img_chaabi/lili labassi.jpg', 'audio_chaabi/lili labassi-ezhiro.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(275, 'GHIZ AJNI OUAHJINI', 4, 41, 'img_chaabi/lili labassi.jpg', 'audio_chaabi/lili labassi-ghiz ajni ouahjini.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(276, 'PARIS PARIS', 4, 41, 'img_chaabi/lili labassi.jpg', 'audio_chaabi/lili labassi-paris paris.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(277, 'EKTEBLI CHOUIYA', 4, 42, 'img_chaabi/line_monty.jpg', 'audio_chaabi/line monty- ektebli chouiya.mp3', 1, 153, 151, '2023-12-03 07:40:42'),
(278, 'YA OUMMI', 4, 42, 'img_chaabi/line_monty.jpg', 'audio_chaabi/line monty- ya oummi.mp3', 1, 151, 150, '2023-12-03 07:40:42'),
(279, 'ANA ENE HOBBEK', 4, 42, 'img_chaabi/line_monty.jpg', 'audio_chaabi/line monty-ana ene hobbek.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(280, 'ANA LOULIA', 4, 42, 'img_chaabi/line_monty.jpg', 'audio_chaabi/line monty-ana loulia.mp3', 1, 150, 150, '2023-12-03 07:40:42'),
(281, 'ANA ELADI BIYA', 4, 43, 'img_chaabi/luc cherki.jpg', 'audio_chaabi/luc cherki-ana eladi biya.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(282, 'GHRAIBI  NAHKIHOUM', 4, 44, 'img_chaabi/maazouz bouadjadj.jpg', 'audio_chaabi/maazouz bouadjadj-ghraibi  nahkihoum.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(283, 'HADA OUAKT  EZZAHOU', 4, 44, 'img_chaabi/maazouz bouadjadj.jpg', 'audio_chaabi/maazouz bouadjadj-hada ouakt  ezzahou.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(284, 'KHOLKHAL AOUICHA', 4, 44, 'img_chaabi/maazouz bouadjadj.jpg', 'audio_chaabi/maazouz bouadjadj-kholkhal aouicha.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(285, 'YA RABI', 4, 46, 'img_chaabi/mhamed yacine.png', 'audio_chaabi/mhamed yacine-ya rabi.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(286, 'BAHR ETOUFANE', 4, 47, 'img_chaabi/mohamed_elbadji_3.jpg', 'audio_chaabi/mohamed el badji-bahr etoufane.mp3', 1, 150, 150, '2023-12-03 07:40:42'),
(287, 'DJAZAIR', 4, 47, 'img_chaabi/mohamed el badji.png', 'audio_chaabi/mohamed el badji-djazair.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(288, 'SAMHOUNI', 4, 47, 'img_chaabi/mohamed el badji.png', 'audio_chaabi/mohamed el badji-samhouni.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(289, 'YAKOUMASSALI', 4, 47, 'img_chaabi/mohamed el badji.png', 'audio_chaabi/mohamed el badji-yakoumassali.mp3', 1, 26, 151, '2023-12-03 07:40:42'),
(290, 'RACHDA', 4, 48, 'img_chaabi/marocain.png', 'audio_chaabi/mohamed marocaine-rachda.mp3', 1, 151, 158, '2023-12-03 07:40:42'),
(291, 'DOUR BIYA', 4, 49, 'img_chaabi/mourad djaafri.jpg', 'audio_chaabi/mourad djaafri-dour biya.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(292, 'LAHWAOUIYA', 4, 49, 'img_chaabi/mourad djaafri.jpg', 'audio_chaabi/mourad djaafri-lahwaouiya.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(293, 'TCHEKTCHEBILA', 4, 49, 'img_chaabi/mourad djaafri.jpg', 'audio_chaabi/mourad djaafri-tchektchebila.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(294, 'AH YA MACHTA', 4, 50, 'img_chaabi/msamae.jpg', 'audio_chaabi/msamae-ah ya machta.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(295, 'MAZAL KHATMAK', 4, 50, 'img_chaabi/msamae.jpg', 'audio_chaabi/msamae-mazal khatmak.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(296, 'Rana Djinek', 4, 50, 'img_chaabi/msamae.jpg', 'audio_chaabi/msamae-rana djinek.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(297, 'WALLAOULILA', 4, 50, 'img_chaabi/msamae-1.jpg', 'audio_chaabi/msamae-wallaoulila.mp3', 1, 28, 151, '2023-12-03 07:40:42'),
(298, 'YA NOUR HINYA', 4, 50, 'img_chaabi/msamae-1.jpg', 'audio_chaabi/msamae-ya nour hinya.mp3', 1, 29, 151, '2023-12-03 07:40:42'),
(299, 'Kolea le 20', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen- kolea le 20-12-2013 part 1.mp3', 2, 25, 150, '2023-12-03 07:40:42'),
(300, 'Anahachqi hadraou ya ahl elhwa', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-anahachqi hadraou ya ahl elhwa.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(301, 'Draria 01 07 2013', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-draria 01 07 2013.mp3', 2, 25, 150, '2023-12-03 07:40:42'),
(302, 'KALOU EL ARAB KALOU', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-kalou el arab kalou.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(303, 'Qoulou Lyamna', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-qoulou lyamna.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(304, 'YA ILLAHI', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-ya illahi.mp3', 1, 25, 150, '2023-12-03 07:40:42'),
(305, 'YA RSOUL ALLAH', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-ya rsoul allah.mp3', 1, 26, 150, '2023-12-03 07:40:42'),
(306, 'fete 16.10.2012 part 2', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete 16.10.2012 part 2.mp3', 2, 31, 150, '2023-12-03 07:40:42'),
(307, 'fete 16.10.2012 part 4', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete 16.10.2012 part 4.mp3', 2, 25, 150, '2023-12-03 07:40:43'),
(308, 'fete I', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete i.mp3', 2, 27, 150, '2023-12-03 07:40:43'),
(309, 'fete II', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete ii.mp3', 2, 25, 150, '2023-12-03 07:40:43'),
(310, 'fete III', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete iii.mp3', 2, 26, 150, '2023-12-03 07:40:43'),
(311, 'fete le 16 10 2012_2', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete le 16 10 2012_2.mp3', 2, 26, 150, '2023-12-03 07:40:43'),
(312, 'fete le 16 10 2012_4', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcen-fete le 16 10 2012_4.mp3', 2, 26, 150, '2023-12-03 07:40:43'),
(313, 'youm el djemaa', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-youm el djemaa- draria le 01 07 2013.mp3', 1, 32, 151, '2023-12-03 07:40:43'),
(314, 'SOIREE COMPLETE A EL HARRACHE le  04 10 2013', 4, 51, 'img_fetes/mustapha belahcene.jpg', 'audio_fetes/mustapha belahcene-soiree complete a el harrache le  04 10 2013.mp3', 2, 25, 150, '2023-12-03 07:40:43'),
(315, 'MOULAT EL KHANA', 4, 52, 'img_chaabi/mustapha boutchiche.png', 'audio_chaabi/mustapha boutchiche-moulat el khana.mp3', 1, 27, 150, '2023-12-03 07:40:43'),
(316, 'YA SADATI WLED TAHA', 4, 53, 'img_chaabi/mostafa-abbassi.png', 'audio_chaabi/mustapha elhabassi-ya sadati wled taha.mp3', 1, 152, 155, '2023-12-03 07:40:43'),
(329, 'BELLAH ALIK YACHEEMA', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-bellah alik yacheema.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(330, 'BINI OU BIN HOUBI', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-bini ou bin houbi.mp3', 1, 26, 150, '2023-12-03 07:40:43'),
(331, 'KHATANOU', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-khatanou.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(332, 'KIF AMALI OU HILTI', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-kif amali ou hilti.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(333, 'MABROUK ALIK TAHARA', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-mabrouk alik tahara.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(334, 'MABROUK ELMAZIOUD', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-mabrouk elmazioud.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(335, 'MAHAL ELKHITABI', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-mahal elkhitabi.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(336, 'RANA DJINEK', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-rana djinek.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(337, 'TAOUHACH ELBAHDJA', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-taouhach elbahdja.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(338, 'YA KOUM SALOU', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-ya koum salou.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(339, 'YA RABI SAHALI ZOURA', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-ya rabi sahali zoura.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(340, 'YALMAZANI', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-yalmazani.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(341, 'YALOUMIMA', 4, 55, 'img_chaabi/nadia benyoucef.jpg', 'audio_chaabi/nadia benyoucef-yaloumima.mp3', 1, 26, 150, '2023-12-03 07:40:43');
INSERT INTO `chansons` (`id`, `titre`, `user_id`, `artiste_id`, `image`, `audio`, `categorie_id`, `views`, `likes`, `created_at`) VALUES
(342, 'CHAMAA DOUWAYA', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-chamaa douwaya.mp3', 1, 26, 150, '2023-12-03 07:40:43'),
(343, 'ELI BLA IYAHF', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-eli bla iyahf.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(344, 'MAMIE CHOUFI', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-mamie choufi.mp3', 1, 26, 150, '2023-12-03 07:40:43'),
(345, 'MANAHRAFCH', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-manahrafch.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(346, 'SERBI LATAYE', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-serbi lataye.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(347, 'SIDI BLAOUI', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-sidi blaoui.mp3', 1, 25, 150, '2023-12-03 07:40:43'),
(348, 'YA NOUR HINIYA', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-ya nour hiniya.mp3', 1, 27, 150, '2023-12-03 07:40:44'),
(349, 'YA NTAYA', 4, 56, 'img_chaabi/nadia dziria.jpg', 'audio_chaabi/nadia dziria-ya ntaya.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(350, 'AYLI AYLI', 4, 57, 'img_chaabi/nadia staifia.jpg', 'audio_chaabi/nadia staifia-ayli ayli.mp3', 1, 27, 151, '2023-12-03 07:40:44'),
(351, 'ANA FI HMEK', 4, 58, 'img_chaabi/nadia yasmine.jpg', 'audio_chaabi/nadia yasmine-ana fi hmek.mp3', 1, 27, 151, '2023-12-03 07:40:44'),
(352, 'YA GOUMRIATE LABROUDJ', 4, 58, 'img_chaabi/nadia yasmine.jpg', 'audio_chaabi/nadia yasmine-ya goumriate labroudj.mp3', 1, 27, 150, '2023-12-03 07:40:44'),
(353, 'ATHALA', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-athala.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(354, 'CHAHA FIHA', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-chaha fiha.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(355, 'HANA', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-hana.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(356, 'MABROUK', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-mabrouk.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(357, 'NIRAN EL HOUB', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-niran el houb.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(358, 'TAHMATE', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-tahmate.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(359, 'YALI SAHROUNI', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-yali sahrouni.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(360, 'YAMEN KALBEK', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-yamen kalbek.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(361, 'YAWLID EL HOUMA', 4, 59, 'img_chaabi/nafia chaffa.jpg', 'audio_chaabi/nafia chaffa-yawlid el houma.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(362, 'AHYA MACHTA', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-ahya machta.mp3', 1, 28, 150, '2023-12-03 07:40:44'),
(363, 'AZIZ ALIYA', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-aziz aliya.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(364, 'BIHA NOU HARBEN', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-biha nou harben.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(365, 'ELHIANE EZERQA', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-elhiane ezerqa.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(366, 'ELQALB TASSALI', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-elqalb tassali.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(367, 'HOUNI KANOU', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-houni kanou.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(368, 'IYANHAWLOU', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-iyanhawlou.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(369, 'RANA DJINEK', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-rana djinek.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(370, 'SALI HOUMOUMEK', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-sali houmoumek.mp3', 1, 25, 151, '2023-12-03 07:40:44'),
(371, 'TOUCHIA', 4, 60, 'img_chaabi/naima.png', 'audio_chaabi/naima-touchia.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(372, 'HADATE DMOUHI', 4, 61, 'img_chaabi/nardjes.jpeg', 'audio_chaabi/nardjes-hadate_dmouhi.mp3', 1, 150, 152, '2023-12-03 07:40:44'),
(373, 'SIFTE ECHEMAA', 4, 61, 'img_chaabi/nardjes.jpeg', 'audio_chaabi/nardjes-sifte echemaa.mp3', 1, 151, 151, '2023-12-03 07:40:44'),
(374, 'DJAH ALAOUDOU', 4, 62, 'img_chaabi/nouri kouffi.jpg', 'audio_chaabi/nouri kouffi-djah alaoudou.mp3', 1, 28, 150, '2023-12-03 07:40:44'),
(375, 'RACHDA', 4, 63, 'img_chaabi/rabah driassa.jpg', 'audio_chaabi/rabah driassa-rachda.mp3', 1, 31, 150, '2023-12-03 07:40:44'),
(376, 'MADJITINICHE', 4, 64, 'img_chaabi/rachid kousyla.png', 'audio_chaabi/rachid kousyla-madjitiniche.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(377, 'BENTE BLADI', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-bente bladi.mp3', 1, 27, 150, '2023-12-03 07:40:44'),
(378, 'DJATDJAT', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-djatdjat.mp3', 1, 27, 150, '2023-12-03 07:40:44'),
(379, 'KAROUM HALABALI', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-karoum halabali.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(380, 'MOULATI YA LALA', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-moulati ya lala.mp3', 1, 28, 150, '2023-12-03 07:40:44'),
(381, 'NARHA HARAGA', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-narha haraga.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(382, 'SIDI SAHNOUN', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-sidi sahnoun.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(383, 'YA EL HADRA', 4, 65, 'img_chaabi/radia adda.jpg', 'audio_chaabi/radia adda-ya el hadra.mp3', 1, 31, 150, '2023-12-03 07:40:44'),
(384, 'EL HINE EZERQA', 4, 66, 'img_chaabi/reda doumaz.jpg', 'audio_chaabi/reda doumaz-el hine ezerqa.mp3', 1, 27, 150, '2023-12-03 07:40:44'),
(385, 'HARAMTOU BIK NOUHASSI', 4, 66, 'img_chaabi/reda doumaz.jpg', 'audio_chaabi/reda doumaz-haramtou bik nouhassi.mp3', 1, 32, 150, '2023-12-03 07:40:44'),
(386, 'MEHLA CHARAF', 4, 66, 'img_chaabi/reda doumaz.jpg', 'audio_chaabi/reda doumaz-mehla charaf.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(387, 'ENHABEK', 4, 67, 'img_chaabi/reinette loranaise.jpg', 'audio_chaabi/reinette loranaise-enhabek.mp3', 1, 26, 150, '2023-12-03 07:40:44'),
(388, 'YA BELLAREDJ', 4, 68, 'img_chaabi/rene perez.png', 'audio_chaabi/rene perez-ya bellaredj.mp3', 1, 25, 150, '2023-12-03 07:40:44'),
(389, 'CHAAHLET LAHYANI', 4, 69, 'img_chaabi/rym.jpg', 'audio_chaabi/rym-chaahlet lahyani.mp3', 1, 28, 150, '2023-12-03 07:40:44'),
(390, 'HASSEBNI OUKHOUD KERRAK', 4, 69, 'img_chaabi/rym hakiki.jpg', 'audio_chaabi/rym-hassebni oukhoud kerrak.mp3', 1, 28, 151, '2023-12-03 07:40:45'),
(391, 'ZAOUDNA FIHMAK', 4, 69, 'img_chaabi/rym.jpg', 'audio_chaabi/rym-zaoudna fihmak.mp3', 1, 28, 151, '2023-12-03 07:40:45'),
(392, 'LAGHRIB', 4, 70, 'img_chaabi/samir toumi & radia manal.jpg', 'audio_chaabi/samir toumi & radia manal-laghrib.mp3', 1, 29, 150, '2023-12-03 07:40:45'),
(393, 'SAARHA', 4, 71, 'img_chaabi/samir toumi.jpg', 'audio_chaabi/samir toumi-saarha.mp3', 1, 26, 150, '2023-12-03 07:40:45'),
(394, 'EL GHOURBA', 4, 72, 'img_chaabi/sidali lekkam.jpg', 'audio_chaabi/sidali lekkam-el ghourba.mp3', 1, 29, 150, '2023-12-03 07:40:45'),
(395, 'GHIR KHALINI', 4, 72, 'img_chaabi/sidali lekkam.jpg', 'audio_chaabi/sidali lekkam-ghir khalini.mp3', 1, 29, 150, '2023-12-03 07:40:45'),
(396, 'KOUL WAHAD YAAREF SLAHO', 4, 72, 'img_chaabi/sidali lekkam.jpg', 'audio_chaabi/sidali lekkam-koul wahad yaaref slaho.mp3', 1, 27, 150, '2023-12-03 07:40:45'),
(397, 'NEBKI OU NOUAH', 4, 72, 'img_chaabi/sidali lekkam.jpg', 'audio_chaabi/sidali lekkam-nebki ou nouah.mp3', 1, 28, 150, '2023-12-03 07:40:45'),
(398, 'YEMA ancien', 4, 72, 'img_chaabi/sidali lekkam.jpg', 'audio_chaabi/sidali lekkam-yema ancien.mp3', 1, 29, 150, '2023-12-03 07:40:45'),
(399, 'YEMA', 4, 72, 'img_chaabi/sidali lekkam.jpg', 'audio_chaabi/sidali lekkam-yema.mp3', 1, 34, 150, '2023-12-03 07:40:45'),
(400, 'LERIAM', 4, 73, 'img_chaabi/tahar fergani.jpg', 'audio_chaabi/tahar fergani-leriam.mp3', 1, 32, 150, '2023-12-03 07:40:45'),
(401, 'INKILAB ZIDANE', 4, 74, 'img_andalou/webc.jpg', 'audio_andalou/taleb kamel-inkilab zidane.mp3', 4, 32, 150, '2023-12-03 07:40:45'),
(402, 'EL BAZ', 4, 75, 'img_chaabi/yassine ouabed.png', 'audio_chaabi/yassine ouabed-el baz.mp3', 1, 27, 150, '2023-12-03 07:40:45'),
(403, 'NEMLA', 4, 75, 'img_chaabi/yassine ouabed.png', 'audio_chaabi/yassine ouabed-nemla.mp3', 1, 41, 150, '2023-12-03 07:40:45'),
(404, 'SOHBA', 4, 75, 'img_chaabi/yassine ouabed.png', 'audio_chaabi/yassine ouabed-sohba.mp3', 1, 48, 150, '2023-12-03 07:40:45'),
(405, 'TKHI LHASBAK YAWELF TAYR', 4, 75, 'img_chaabi/yassine ouabed.png', 'audio_chaabi/yassine ouabed-tkhi lhasbak yawelf tayr.mp3', 1, 41, 150, '2023-12-03 07:40:45'),
(406, 'YA MJARBINE LAHWA', 4, 75, 'img_chaabi/yassine ouabed.png', 'audio_chaabi/yassine ouabed-ya mjarbine lahwa.mp3', 1, 5, 150, '2023-12-03 07:40:45'),
(407, 'YACINE OUABED', 4, 75, 'img_chaabi/yassine ouabed.png', 'audio_chaabi/yassine ouabed-yacine ouabed.mp3', 1, 46, 151, '2023-12-03 07:40:45'),
(408, 'Atir elqafs', 4, 79, 'img_chaabi/cheikh hsissen_2.jpg', 'audio_chaabi/cheikh hsissen-atir elqafs.mp3', 1, 31, 150, '2023-12-20 12:41:39'),
(409, 'Rah tiri nhar eldjemaa', 4, 79, 'img_chaabi/cheikh hsissen.jpeg', 'audio_chaabi/cheikh hsissen-rah tiri nhar eldjemaa.mp3', 1, 5, 4, '2023-12-20 12:45:45'),
(410, 'YEMA', 4, 75, 'img_chaabi/ouabed.png', 'audio_chaabi/yassine ouabed-yema.mp3', 1, 45, 150, '2024-05-30 14:34:17'),
(411, 'youm el djemaa 1976', 4, 7, 'img_chaabi/abdelrezak bougataya.jpg', 'audio_chaabi/abderrezak bouguettaya-youm el djemaa 1976  الجزائر عبد الرزاق بوقطايا- يوم الجمعة.mp3', 1, 68, 155, '2024-12-24 20:08:07'),
(412, 'maychali youm al harb', 4, 22, 'img_chaabi/el_hadj_el_anka_2.jpeg', 'audio_chaabi/el hadj med el anka-maychali youm al harb ghir.mp3', 1, 7, 159, '2024-12-24 22:09:04'),
(416, 'qoulou lyamna', 4, 51, 'img_chaabi/mustapha belahcen.png', 'audio_chaabi/mustapha belahcen-qoulou lyamna.mp3', 1, 58, 159, '2024-12-25 16:50:24'),
(417, 'soubhan allah yaltif\r\nسبحان الله يا لطيف', 4, 51, 'img_chaabi/mustapha belahcene_1.jpg', 'audio_chaabi/mustapha belahcene-soubhan.mp3', 1, 6, 159, '2024-12-25 17:30:14'),
(419, 'BAHR ETOUFANE', 4, 17, 'img_chaabi/elankis_boudjemaa.jpg', 'audio_chaabi/boudjemaa_el_ankis-bahr_toufane.mp3', 1, 25, 151, '2025-09-21 16:03:01'),
(420, 'Chioukh Bladi - Ajbouni', 4, 49, 'img_chaabi/mourade_djaafri.jpeg', 'audio_chaabi/mourade_djaafri-chioukh_bladi_ajbouni.mp3', 1, 154, 151, '2025-09-28 20:36:23'),
(421, 'Ya Ali', 4, 110, 'img_chaabi/mail.jpeg', 'audio_chaabi/reda DJILALI_Ya Ali.mp3', 1, 154, 151, '2025-10-22 09:40:28');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE IF NOT EXISTS `commentaires` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`id`, `nom`, `email`, `message`, `rating`, `created_at`) VALUES
(1, 'Mahfoud', 'mahfoud@tutanota.com', 'Salem alikoom, nouveau site du chaabi dialna ... j\'espère qu\'il vous plaira..', 5, '2024-12-29 17:56:43'),
(2, 'Mahfoud', 'mahfoud@tutanita.com', 'Saha AIDKOUM', 4, '2025-04-02 15:55:42'),
(3, 'Mahfoud', 'mahfoud@tutanita.com', 'SAHA AIDKOUM', 4, '2025-04-02 15:56:12'),
(4, 'toto', 'toto@yahoo.com', 'Salem elikoom', 3, '2025-04-08 21:21:49'),
(5, 'Mahfoud', 'toto@yahoo.com', 'AID Moubarek à tous...', 0, '2025-04-11 18:02:30'),
(6, 'Mahfoud', 'mahfoud@tutanota.com', 'Salem alikoum AID Moubarak inchallah ... à tous les musulman...', 5, '2025-04-12 14:19:18'),
(7, 'Grok', 'memac26943@ikanteri.com', 'Pas satisfesant ce site, il manque la pagination, une meilleurs presentaion, un design mieux que ça ect...', 2, '2025-07-30 13:12:52'),
(8, 'Maroua', 'xabef66162@mardiek.com', 'Un site digne des coutumes et de l\'art Algérien, le chaâbi est notre patrimoine ! Merci', 4, '2025-08-18 11:14:13'),
(9, 'Adam', 'joxovog636@skateru.com', 'Super site de la musique populaire Algérienne le CHAABI...encouragement pour faire plus ... Merci', 4, '2025-09-01 13:35:49');

-- --------------------------------------------------------

--
-- Structure de la table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'le message dans contact',
  `sujet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `contacts`
--

INSERT INTO `contacts` (`id`, `nom`, `email`, `phone`, `message`, `sujet`, `created_at`) VALUES
(1, 'Jane Strong', 'janestrong@example.com', '2026550143', '', 'Lawyer', '2021-05-08 17:32:00'),
(2, 'Dwayne Johnson', 'dwaynejohnson@example.com', '2025550121', '', 'Employee', '2021-05-08 17:28:44'),
(3, 'Mitch Maypol', 'mitchmaypol@example.com', '2004550121', '', 'Employee', '2021-05-08 17:29:27'),
(4, 'Jaggy Davidson', 'jaggydavidson@example.com', '2022550178', '', 'Supervisor', '2021-05-08 17:29:27'),
(5, 'John Clover', 'johnclover@example.com', '7862342390', '', 'Janitor', '2021-05-09 19:16:00'),
(6, 'Adam', 'joxovog636@skateru.com', '0569854598', '', 'Partenariat', '2025-09-01 13:50:58'),
(8, 'Nacer', 'joxovog636@skateru.com', '6598745458', 'Peut on écouter des fêtes en intégrale ? Merci', 'Question générale', '2025-09-01 14:00:26');

-- --------------------------------------------------------

--
-- Structure de la table `dedicaces`
--

DROP TABLE IF EXISTS `dedicaces`;
CREATE TABLE IF NOT EXISTS `dedicaces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pour` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_dedicaces_created_at` (`created_at`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `dedicaces`
--

INSERT INTO `dedicaces` (`id`, `nom`, `pour`, `description`, `likes`, `created_at`) VALUES
(1, 'yazid', 'ceux qui aime le chaabi', 'si  y avais pas le CHAABI aucune vie n\'est possible surtout avec confinement. cloué a la maison notre seul reméde écouter du chaabi sa détresse. ', 1, '2020-08-01 14:01:09'),
(2, 'Kool**', 'Tous les Algériens', 'H\'na Inchallah Rana Algien Kabyle', 1, '2020-09-10 17:02:43'),
(3, 'yacine', 'ali; Med; zoubir et zoubir, rachid, bronco de Beni', 'avec toutes mes amitiés depuis amar ranvalé à  amar ezzahi', 1, '2022-10-12 17:03:49'),
(4, 'Mahfoud', 'Tout le Monde', 'Mouloud Moubarek...inchallah pour tous...', 1, '2020-10-29 09:33:43'),
(5, 'Mahfoud', 'Tout le Monde...', 'Ajout de plusieurs qacidattes...\r\ndans la rubrique qacidattes...Merci à tous...', 1, '2021-03-14 18:20:43'),
(6, 'Mahfoud', 'Tout le Monde', 'Salem alikoom...j\'espére que l\'année était bonne pour vous..', 2, '2021-01-01 12:45:43'),
(7, 'Adam', 'Toute la famille', 'Bonne Année et Bone Santé 2022...', 1, '2021-01-18 15:41:43'),
(8, 'Mahfoud', 'tous les internautes', 'SAHA RAMDANKOUM...SAHA FTOURKOUM..', 1, '2022-04-11 14:40:43'),
(9, 'Mahfoud', 'Toute l\'humanité', 'AIDKOOM MOUBAREK....AIDKOOM MOUBAREK...AIDKOOM MOUBAREK...', 7, '2022-05-02 04:09:43'),
(10, 'BALADI', 'LES 4 CHAINES', 'BEUR FM FRANCE MAGHREB RADIO ORION RADIO SOLEIL....BRAVO et https://webchaabi.com', 1, '2022-06-07 14:08:43'),
(11, 'Mahfoud', 'Tout le monde', 'AIDKOUM MOUBAREK...Bonne Féte de L\'Aid à  tous.....', 1, '2022-07-09 12:26:43'),
(12, 'MILOUD  Hassi Messaoud ', 'Travailleurs SONATRACH  DP- HMD  Hassi messaoud', 'EID MAWLID NABAWI SAIID    KOL AAM W NTOUM BI 100 KHEIR  RABBI YAHFADKOUM', 1, '2022-10-06 17:40:43'),
(13, 'Mahfoud', 'tout le monde', 'Saha Mouloud koum...Mouloud moubarek à tous...', 1, '2022-10-06 21:46:43'),
(14, 'RIAD YAHIAOUI', 'FAMILLE YAHIAOUI ', 'SAHA MOULOUDKOUM ET JOUMOU3A MOUBARAKA  FAMILLE YAHIAOUI TIBERGUENT ET SONATRACH HASSI MESSAOUD ', 1, '2022-10-07 15:05:43'),
(15, 'Mahfoud', 'tout le monde', 'À vous tous... nouveauté sur le site. !!!', 1, '2022-11-24 13:50:09'),
(16, 'mahfoud', 'les internautes', 'un nouveau travail sur le site...', 2, '2022-11-24 20:10:15'),
(17, 'Mahfoud', 'l\'humanité', 'BONNE ET HEUREUSE ANNEE 2023...', 1, '2023-01-01 15:08:53'),
(18, 'Mahfoud', 'Tout le Monde', 'À l\'occasion du mois de Ramadan, je vous souhaite à tous un Ramadan Moubarek INCHALLAH.', 1, '2023-03-22 15:38:37'),
(19, 'Mahfoud', 'Tout le monde', 'A l\'occasion du AId el iftar, je vous SOUHAIT UN AID MOUBAREK INCHALLAH...', 1, '2023-04-20 21:19:01'),
(20, 'Mahfoud', 'Tous les humains', 'Saha aidkoum...Aid moubarek...', 1, '2023-06-27 18:32:35'),
(21, 'AMAR', 'le monde entier', 'Salem alikoom Ya lahbab', 1, '2023-11-14 02:18:58'),
(22, 'fadila', 'Toute la famille', 'Bon Ramadan', 2, '2023-11-14 02:29:45'),
(23, 'Smain', 'l\'humanité', 'Que la paix règne sur la terre', 2, '2023-11-14 02:31:22'),
(24, 'Adam', 'Les dégustateurs', 'Bonne Appétit', 2, '2023-11-14 02:33:44'),
(25, 'Adam', 'mes amis', 'Pour tous les gameurs.....', 6, '2025-07-28 17:10:04'),
(26, 'Maroua', 'ma famille', 'J\'espéré que vous allez tous bien....', 6, '2025-08-17 11:29:19'),
(27, 'Adam', 'tout le monde', 'Super site de la musique populaire Algérienne le CHAABI...encouragement pour faire plus ... Merci', 9, '2025-09-01 13:39:48'),
(28, 'Dalila', 'Ma mere', 'Ahmdou lillah li khardjete Salamatte', 15, '2025-09-27 16:42:39'),
(29, 'Mahfoud', 'Mes internautes', 'Bientôt un nouveau look pour le site webchaabi.com...Merci', 8, '2025-09-27 17:50:04');

-- --------------------------------------------------------

--
-- Structure de la table `emissions`
--

DROP TABLE IF EXISTS `emissions`;
CREATE TABLE IF NOT EXISTS `emissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_emission` int NOT NULL COMMENT 'Numéro séquentiel de l''émission',
  `titre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Titre de l''émission',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Description détaillée de l''émission',
  `image` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nom du fichier image (sans le chemin)',
  `audio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nom du fichier audio (sans le chemin)',
  `categorie_id` int NOT NULL COMMENT 'ID de la catégorie',
  `animateur_id` int NOT NULL COMMENT 'ID de l''animateur (user)',
  `views` int DEFAULT '0' COMMENT 'Nombre de vues',
  `likes` int DEFAULT '0' COMMENT 'Nombre de likes',
  `date_emission` datetime DEFAULT NULL COMMENT 'Date et heure de diffusion prévue/réalisée',
  `date_creation` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Date de création en base',
  `date_modification` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Dernière modification',
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_emission` (`numero_emission`),
  KEY `idx_numero_emission` (`numero_emission`),
  KEY `idx_date_emission` (`date_emission`),
  KEY `idx_categorie` (`categorie_id`),
  KEY `idx_animateur` (`animateur_id`),
  KEY `idx_vues` (`views`),
  KEY `idx_emissions_date_emission` (`date_emission`),
  KEY `idx_emissions_numero` (`numero_emission`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table des émissions de radio - Version améliorée';

--
-- Déchargement des données de la table `emissions`
--

INSERT INTO `emissions` (`id`, `numero_emission`, `titre`, `description`, `image`, `audio`, `categorie_id`, `animateur_id`, `views`, `likes`, `date_emission`, `date_creation`, `date_modification`) VALUES
(1, 81, 'EMISSION 81e 23 02 04', 'Émission de Chaabi Dialna - EMISSION 81e 23 02 04', 'img_emissions/boudraa1.jpg', 'audio_emissions/mahfoud-emission 81e 23 02 04.mp3', 3, 4, 183, 158, '2004-02-23 07:40:43', '2004-02-23 07:40:43', '2026-02-09 18:10:57'),
(2, 87, 'EMISSION 87e 05 04 04', 'Émission de Chaabi Dialna', 'img_emissions/badji_mah.jpg', 'audio_emissions/mahfoud-emission 87e 05 04 04.mp3', 3, 4, 164, 158, '2004-04-05 05:40:00', '2023-12-03 07:40:43', '2026-01-18 11:40:46'),
(3, 139, 'Emission 139e 26 09 05', 'Émission de Chaabi Dialna - Emission 139e 26 09 05', 'img_emissions/djaafri_mah.jpg', 'audio_emissions/mahfoud-emission 139e 26 09 05.mp3', 3, 4, 119, 167, '2005-09-26 07:40:43', '2023-12-03 07:40:43', '2026-03-31 22:48:47'),
(4, 88, 'Emission 88e 12 04 04', 'Émission de Chaabi Dialna - Emission 88e 12 04 04', 'img_emissions/mahfoud (2).jpg', 'audio_emissions/mahfoud-emission 88e 12 04 04.mp3', 3, 4, 184, 156, '2004-04-12 07:40:43', '2023-12-03 07:40:43', '2026-04-09 09:19:19'),
(5, 89, 'Emission 89e 19 04 04', 'Émission de Chaabi Dialna - Emission 89e 19 04 04', 'img_emissions/chaabi dialna.png', 'audio_emissions/mahfoud-emission 89e 19 04 04.mp3', 3, 4, 171, 154, '2004-04-19 07:40:43', '2023-12-03 07:40:43', '2026-03-31 22:49:15'),
(6, 90, 'Emission 90e 26 04 04', 'Émission de Chaabi Dialna - Emission 90e 26 04 04', 'img_emissions/groupe2.jpg', 'audio_emissions/mahfoud-emission 90e 26 04 04.mp3', 3, 4, 164, 153, '2004-04-04 07:40:43', '2023-12-03 07:40:43', '2026-02-09 18:10:37'),
(7, 91, 'Emission 91e 10 05 04', 'Émission de Chaabi Dialna - Emission 91e 10 05 04', 'img_emissions/festival-1.jpg', 'audio_emissions/mahfoud-emission 91e 10 05 04.mp3', 3, 4, 173, 153, '2004-05-04 07:40:43', '2023-12-03 07:40:43', '2026-03-31 17:00:19'),
(8, 92, 'Emission 92e 17 05 04', 'Émission de Chaabi Dialna - Emission 92e 17 05 04', 'img_emissions/festival-1.jpg', 'audio_emissions/mahfoud-emission 92e 17 05 04.mp3', 3, 4, 107, 153, '2004-05-17 00:00:00', '2004-05-17 00:00:00', '2026-03-31 19:39:11'),
(9, 93, 'Emission 93e 24 05 04', 'Émission de Chaabi Dialna - Emission 93e 24 05 04', 'img_emissions/boudraa1.jpg', 'audio_emissions/mahfoud-emission 93e 24 05 04.mp3', 3, 4, 166, 154, '2004-05-24 23:40:43', '2023-12-03 07:40:43', '2026-03-31 18:05:49'),
(10, 94, 'Emission 94e 07 06 04', 'Émission de Chaabi Dialna', 'img_emissions/badji_mah.jpg', 'audio_emissions/mahfoud-emission 94e 07 06 04.mp3', 3, 4, 175, 156, '2004-06-07 07:40:43', '2023-12-03 07:40:43', '2026-04-06 17:07:12'),
(11, 95, 'Emission 95e 14 06 04', 'Émission de Chaabi Dialna - Emission 95e 14 06 04', 'img_emissions/mahfoud (2).jpg', 'audio_emissions/mahfoud-emission 95e 14 06 04.mp3', 3, 4, 166, 154, '2004-06-14 07:40:43', '2023-12-03 07:40:43', '2026-03-31 18:05:40'),
(12, 82, 'Emission 82e', 'Émission de Chaabi Dialna - Emission 82e', 'img_emissions/groupe2.jpg', 'audio_emissions/mahfoud-emission 82e 01-03-04.mp3', 3, 4, 158, 153, '2004-03-01 00:00:00', '2004-03-01 00:00:00', '2026-02-09 18:10:33'),
(13, 96, 'Emission 96e', 'Émission de Chaabi Dialna - Emission 96e', 'img_emissions/chaou_mah.jpg', 'audio_emissions/mahfoud_emission 96e 21-06-04.mp3', 3, 4, 169, 153, '2004-06-21 00:00:00', '2004-06-21 00:00:00', '2026-03-31 18:05:44'),
(15, 52, 'Emission 52e 19-05-03', 'Émission de Chaabi Dialna - Emission 52e 19-05-03', 'img_emissions/festival-1.jpg', 'audio_emissions/mahfoud_emission_52e_19-05-03.mp3', 3, 4, 176, 162, '2003-05-19 10:57:49', '2025-08-15 10:57:49', '2026-01-28 13:54:21'),
(16, 32, 'Emission 32e 18-11-2002', 'Émission de Chaabi Dialna - Emission 32e 18-11-2002', 'img_emissions/rais_djaafri_mah.jpg', 'audio_emissions/mahfoud_emission_32e_18-11-2002.mp3', 3, 4, 168, 156, '2002-11-18 09:07:21', '2025-08-16 09:07:21', '2025-11-19 13:45:52'),
(17, 9, 'Emission Chaabbi Dialna', 'Invitée Chafia Boudraa', 'img_emissions/boudraa.png', 'audio_emissions/mahfoud_emission 9e_1-04-02.mp3', 1, 4, 236, 275, '2002-04-01 18:00:00', '2025-10-06 00:00:54', '2026-04-14 13:49:44'),
(18, 44, 'emission 44e_10-02-2003', 'Invité Abdelkaser Chaou', 'img_emissions/chaou_mah.jpg', 'audio_emissions/mahfoud_emission 44e_10-02-2003.mp3', 3, 4, 260, 161, '2003-02-10 18:00:00', '2025-10-07 21:04:54', '2026-04-07 20:04:21'),
(21, 41, 'Chaabi Dialna', 'Invitée El Hachemi Guerouabi', 'img_emissions/emi011.jpg', 'audio_emissions/mahfoud_emission 41e_20-01-2003.mp3', 3, 4, 252, 163, '2003-01-20 21:00:00', '2025-10-19 18:08:05', '2026-04-29 11:54:12'),
(22, 1, 'Chaabi Dialna', 'Plusieurs Invités', 'img_emissions/groupe2.jpg', 'audio_emissions/mahfoud_emission 1e_4-02-02.mp3', 3, 4, 227, 153, '2002-02-04 18:00:00', '2025-10-22 09:44:19', '2026-04-01 12:58:19'),
(23, 14, 'Chaabi Dialna', 'Invité Boualem rahma', 'img_emissions/rahma.png', 'audio_emissions/mahfoud_emission 14e_06-05-02.mp3', 3, 4, 162, 151, '2002-05-06 19:00:00', '2025-10-22 11:44:48', '2026-02-09 16:59:09'),
(25, 98, 'Chaabi Dialna', NULL, 'img_emissions/mahfoud-2.png', 'audio_emissions/mahfoud_emisssion 98e_20-09-2004.mp3', 3, 4, 160, 156, '2004-09-20 19:00:00', '2025-10-22 17:26:07', '2026-04-09 12:20:50'),
(26, 100, 'Chaabi Dialna', NULL, 'img_emissions/Logoradio.png', 'audio_emissions/mahfoud_emisssion 100e_04-10-2004.mp3', 3, 4, 163, 150, '2004-10-04 19:00:00', '2025-10-22 17:28:07', '2026-02-09 19:50:04'),
(27, 99, 'Chaabi Dialna', NULL, 'img_emissions/Radio Chaabi Dialna.png', 'audio_emissions/mahfoud_emisssion 99e_27-09-2004.mp3', 3, 4, 158, 150, '2004-09-27 19:00:00', '2025-10-22 17:30:12', '2026-03-31 21:52:32'),
(28, 101, 'Chaabi Dialna', NULL, 'img_emissions/meknassia_img.png', 'audio_emissions/mahfoud_emisssion 101e_11-10-2004.mp3', 3, 4, 163, 152, '2004-10-11 19:00:00', '2025-10-22 17:32:00', '2026-03-31 20:47:36'),
(29, 102, 'Chaabi Dialna', NULL, 'img_emissions/radiochaabi.jpeg', 'audio_emissions/mahfoud_emisssion 102e_18-10-2004.mp3', 3, 4, 163, 150, '2004-10-18 19:00:00', '2025-10-22 17:33:12', '2026-03-31 18:05:30'),
(30, 83, 'Chaabi Dialna', NULL, 'img_emissions/hero.png', 'audio_emissions/mahfoud_emisssion 83e_08-03-2004.mp3', 3, 4, 154, 150, '2004-03-08 19:00:00', '2025-10-22 17:35:41', '2025-11-03 14:25:12'),
(31, 5, 'Chaabi Dialna', 'Mon anniversaire !!!', 'img_emissions/mahfoud-0l.jpg', 'audio_emissions/mahfoud_emission 5e_04-03-02.mp3', 3, 4, 159, 153, '2002-03-04 19:00:00', '2025-10-22 17:41:51', '2026-01-09 11:18:34'),
(32, 10, 'Chaabi Dialna', 'Invitée Leila Mahzouz', 'img_emissions/mail.jpeg', 'audio_emissions/mahfoud_emission 10e_08-04-02.mp3', 3, 4, 167, 152, '2002-04-08 19:00:00', '2025-10-22 17:46:20', '2026-04-02 13:49:49'),
(33, 2, 'Chaabi Dialna', NULL, 'img_emissions/radiochabidialna.jpg', 'audio_emissions/mahfoud_emission 2e_11-02-02.mp3', 3, 4, 153, 150, '2002-02-11 19:00:00', '2025-10-22 17:49:49', '2025-11-05 13:49:27'),
(34, 11, 'Chaabi Dialna', NULL, 'img_emissions/logo.png', 'audio_emissions/mahfoud_emission 11e_15-04-02.mp3', 3, 4, 154, 150, '2002-04-15 19:00:00', '2025-10-22 17:51:28', '2025-11-09 17:18:42'),
(35, 3, 'Chaabi Dialna', NULL, 'img_emissions/chaabidialna.png', 'audio_emissions/mahfoud_emission 3e_18-02-02.mp3', 3, 4, 154, 150, '2004-02-18 19:00:00', '2025-10-22 17:53:30', '2025-11-03 14:25:12'),
(36, 7, 'Chaabi Dialna', NULL, 'img_emissions/default.jpg', 'audio_emissions/mahfoud_emission 7e_18-03-02.mp3', 3, 4, 152, 151, '2002-03-18 19:00:00', '2025-10-22 17:54:42', '2026-02-09 21:03:31'),
(37, 12, 'Chaabi Dialna', NULL, 'img_emissions/ambiance.jpg', 'audio_emissions/mahfoud_emission 12e_22-04-02.mp3', 3, 4, 153, 150, '2002-04-22 19:00:00', '2025-10-22 17:55:56', '2025-11-05 20:13:34'),
(38, 13, 'Chaabi Dialna', NULL, 'img_emissions/Mahfoud.png', 'audio_emissions/mahfoud_emission 13e_23-04-02.mp3', 3, 4, 154, 152, '2002-04-23 19:00:00', '2025-10-22 17:57:22', '2025-11-19 17:58:58'),
(39, 4, 'Chaabi Dialna', 'Invité Noureddine Alane', 'img_emissions/noureddine_alane.jpg', 'audio_emissions/mahfoud_emission 4e_25-02-02.mp3', 3, 4, 180, 153, '2002-02-25 19:00:00', '2025-10-22 18:00:03', '2026-04-02 16:25:04'),
(40, 8, 'Chaabi Dialna', NULL, 'img_emissions/radiochaabi.webp', 'audio_emissions/mahfoud_emission 8e_25-03-02.mp3', 3, 4, 154, 151, '2002-03-25 19:00:00', '2025-10-22 18:01:30', '2026-04-06 17:53:17'),
(41, 6, 'Chaabi Dialna', NULL, 'img_emissions/Radio Chaabi Dialna.jpg', 'audio_emissions/mahfoud_emission 6e_11-03-02.mp3', 3, 4, 155, 151, '2002-03-11 19:00:00', '2025-10-22 18:02:57', '2026-01-09 11:18:35'),
(42, 16, 'Chaabi Dialna', NULL, 'img_emissions/badji_mah.jpg', 'audio_emissions/mahfoud_emission 16e_20-05-2002.mp3', 3, 4, 154, 150, '2002-05-20 19:00:00', '2025-10-22 18:04:27', '2025-11-03 14:25:17'),
(43, 97, 'Chaabi Dialna', NULL, 'img_emissions/wc13.jpg', 'audio_emissions/mahfoud_emisssion 97e_28-06-2004.mp3', 3, 4, 159, 152, '2004-06-28 19:00:00', '2025-10-23 16:48:50', '2026-03-31 18:16:45'),
(44, 109, 'Chaabi Dialna', NULL, 'img_emissions/boudraa3.jpg', 'audio_emissions/mahfoud_emisssion 109e_06-12-2004.mp3', 3, 4, 168, 156, '2004-12-06 19:00:00', '2025-10-23 16:50:16', '2026-04-09 09:24:20'),
(45, 15, 'Chaabi Dialna', 'début sur le festival du chaabi', 'img_emissions/chaabi.jpg', 'audio_emissions/mahfoud_emission 15e_13-05-2002.mp3', 3, 4, 155, 151, '2002-05-13 19:00:00', '2025-10-23 16:51:42', '2026-01-18 14:44:32'),
(46, 17, 'Chaabi Dialna', 'invité Sid Ali LEKKAM', 'img_emissions/sidali_lekkam.jpeg', 'audio_emissions/mahfoud_emission 17e_27-05-2002.mp3', 3, 4, 157, 150, '2002-05-27 19:00:00', '2025-10-23 16:56:23', '2025-11-13 15:35:40'),
(49, 18, 'Chaabi Dialna', 'invité Baya Belal\nInterviews Nadia Benyoucef', 'img_emissions/baya_belal-1.jpeg', 'audio_emissions/mahfoud_emission 18e_03-06-2002.mp3', 3, 4, 135, 175, '2002-06-03 19:00:00', '2025-10-26 14:30:00', '2026-04-09 07:42:10'),
(50, 23, 'Chaabi Dialna', NULL, 'img_emissions/groupe2.jpg', 'audio_emissions/mahfoud_emission 23e_16-09-2002.mp3', 3, 4, 180, 101, '2002-09-16 19:00:00', '2025-10-26 14:59:03', '2026-02-09 18:09:51'),
(51, 24, 'Chaabi Dialna', NULL, 'img_emissions/chafia-mah.jpg', 'audio_emissions/mahfoud_emission 24e_23-09-2002.mp3', 3, 4, 121, 140, '2002-09-23 19:00:00', '2025-10-26 15:10:04', '2026-02-09 18:12:28'),
(52, 25, 'Chaabi Dialna', NULL, 'img_emissions/radiologo.png', 'audio_emissions/mahfoud_emission 25e_30-09-2002.mp3', 3, 4, 123, 220, '2002-09-30 19:00:00', '2025-10-26 15:11:23', '2026-02-09 18:12:35'),
(53, 26, 'Chaabi Dialna', NULL, 'img_emissions/5f.jpg', 'audio_emissions/mahfoud_emission 26e_07-10-2002.mp3', 3, 4, 128, 220, '2002-10-07 19:00:00', '2025-10-26 15:12:56', '2026-02-09 18:12:38'),
(54, 27, 'Chaabi Dialna', NULL, 'img_emissions/SK DJI_0552 - Copie.jpg', 'audio_emissions/mahfoud_emission 27e_14-10-2002.mp3', 3, 4, 120, 120, '2002-10-14 19:00:00', '2025-10-26 15:14:18', '2026-02-09 18:12:23'),
(55, 29, 'Chaabi Dialna', NULL, 'img_emissions/DSC025490184.jpg', 'audio_emissions/mahfoud_emission 29e_28-10-2002.mp3', 3, 4, 180, 111, '2002-10-28 19:00:00', '2025-10-26 15:15:19', '2026-02-09 18:12:18'),
(56, 30, 'Chaabi Dialna', NULL, 'img_emissions/P125544101fc.jpg', 'audio_emissions/mahfoud_emission 30e_04-11-2002.mp3', 3, 4, 150, 110, '2002-11-04 19:00:00', '2025-10-26 15:16:30', '2026-02-09 18:12:14'),
(57, 36, 'Chaabi Dialna', 'Invite Sid Hamed Lahbib', 'img_emissions/festival-1.jpg', 'audio_emissions/mahfoud_emission 36e_16-12-2002.mp3', 3, 4, 160, 104, '2002-12-16 19:00:00', '2025-10-26 15:19:52', '2026-02-09 18:12:08'),
(58, 40, 'Chaabi Dialna', 'Invite Samira', 'img_emissions/1pay.jpg', 'audio_emissions/mahfoud_emission 40e_13-01-2003.mp3', 3, 4, 124, 210, '2003-01-13 19:00:00', '2025-10-26 15:25:42', '2026-02-09 18:12:31'),
(59, 51, 'Chaabi Dialna', 'Invite Chafia Boudraa', 'img_emissions/chafia-mah.jpg', 'audio_emissions/mahfoud_emission 51e_12-05-2003.mp3', 3, 4, 123, 141, '2003-05-12 19:00:00', '2025-10-26 15:39:04', '2026-04-02 13:50:16'),
(60, 108, 'Chaabi Dialna', NULL, 'img_emissions/mah-guerouabi.jpg', 'audio_emissions/mahfoud_emisssion 108e_29-11-2004.mp3', 3, 4, 133, 140, '2004-11-29 19:00:00', '2025-10-26 15:49:08', '2026-02-09 18:12:43');

-- --------------------------------------------------------

--
-- Structure de la table `emission_comments`
--

DROP TABLE IF EXISTS `emission_comments`;
CREATE TABLE IF NOT EXISTS `emission_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emission_id` int NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','spam') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `idx_emission` (`emission_id`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `emission_comments`
--

INSERT INTO `emission_comments` (`id`, `emission_id`, `nom`, `email`, `message`, `created_at`, `user_ip`, `status`) VALUES
(1, 1, 'Ahmed Benali', 'ahmed@email.com', 'Excellente émission ! J\'ai adoré les invités.', '2025-10-10 14:36:02', NULL, 'pending'),
(2, 1, 'Fatima Zohra', 'fatima@email.com', 'Très intéressant, merci pour ce contenu de qualité.', '2025-10-10 14:36:02', NULL, 'pending'),
(3, 2, 'Karim Mansouri', 'karim@email.com', 'Belle découverte musicale, continuez comme ça!', '2025-10-10 14:36:02', NULL, 'pending'),
(4, 3, 'Mahfoud', 'mahfoud.z@proton.me', 'Super Emission ! ça me rappel des soubenirs', '2025-10-13 22:12:39', NULL, 'pending'),
(5, 17, 'Mahfoud', 'mahfoud.z@proton.me', 'Une grande Amie !!! une grande Dame !!! une Grande Actrice...Mon regrettée amie Chafia .', '2025-10-13 22:34:48', NULL, 'pending'),
(6, 13, 'Mahfoud', 'mahfoud.z@proton.me', 'Mon émission préférer je crois..', '2025-10-13 22:52:05', NULL, 'pending'),
(7, 11, 'Mahfoud', NULL, 'Ah oui tres bonne émission... a vous de voir !', '2025-10-17 09:47:43', NULL, 'pending'),
(8, 9, 'Mahfoud', NULL, 'Nostaligie... Bonne écoute à tous', '2025-10-17 10:23:10', NULL, 'pending'),
(9, 8, 'Mahfoud', 'mahfoud.z@proton.me', 'Une emission interressante avec sid hamed ! tres bonne discussion !', '2025-10-18 16:17:28', NULL, 'pending'),
(10, 21, 'Mahfoud', NULL, 'Bien ! avec el marhoum el hadj elhachmi Guerouabi !!! Ecoutez...', '2025-10-19 16:31:34', NULL, 'pending'),
(11, 59, 'Dialna', 'dialna@gmail.com', 'Salem alikoom Tres bonne emission', '2026-01-28 12:54:06', NULL, 'pending'),
(12, 44, 'Mahfoud', NULL, 'ça me rappel des souvenirs ...Merci a vous !', '2026-02-05 20:26:29', NULL, 'pending'),
(13, 60, 'Mahfoud', NULL, 'A tres belle émissions...Merci a tous', '2026-02-05 20:32:33', NULL, 'pending'),
(14, 15, 'Mahfoud', NULL, 'C\'etait le bon temp des emissions chaabi dialna', '2026-02-07 17:48:39', NULL, 'pending'),
(15, 28, 'Mahfoud', NULL, 'J\'aime bien cette Emission ....', '2026-02-07 17:55:03', NULL, 'pending'),
(16, 27, 'Mahfoud', NULL, 'Ecouter l\'émission et dites moi ce que vous en penser ?! Merci', '2026-02-08 07:57:40', NULL, 'pending'),
(17, 18, 'Mahfoud', NULL, 'Super emission ...Ecoutez la et dites moi des nouvelles....', '2026-02-08 10:12:27', NULL, 'pending'),
(18, 5, 'Mahfoud', NULL, 'Nostalgie...', '2026-03-31 20:49:15', NULL, 'pending');

-- --------------------------------------------------------

--
-- Structure de la table `emission_invites`
--

DROP TABLE IF EXISTS `emission_invites`;
CREATE TABLE IF NOT EXISTS `emission_invites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emission_id` int NOT NULL,
  `artiste_id` int DEFAULT NULL,
  `invite_externe_nom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invite_externe_type` enum('Acteur','Actrice','Journaliste','Historien','Animatrice','Animateur','Autre') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invite_externe_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `invite_externe_bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ordre` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_emission_artiste` (`emission_id`,`artiste_id`),
  KEY `idx_emission` (`emission_id`),
  KEY `idx_artiste` (`artiste_id`),
  KEY `idx_emission_artiste` (`emission_id`,`artiste_id`),
  KEY `idx_invite_externe_nom` (`invite_externe_nom`(100)),
  KEY `idx_emission_artiste_ordre` (`emission_id`,`artiste_id`,`ordre`)
) ;

--
-- Déchargement des données de la table `emission_invites`
--

INSERT INTO `emission_invites` (`id`, `emission_id`, `artiste_id`, `invite_externe_nom`, `invite_externe_type`, `invite_externe_image`, `invite_externe_bio`, `ordre`, `created_at`) VALUES
(29, 17, NULL, 'Chafia Boudraa', 'Actrice', 'img_invites/boudraa_1760366899.jpg', 'Chafia Boudrâa (1930–2022) Chafia Boudrâa, de son vrai nom Atika Boudrâa, est née le 22 avril 1930 à Constantine, en Algérie. Figure emblématique du théâtre, du cinéma et de la télévision algérienne, elle a marqué plusieurs générations par son talent, sa sensibilité et son engagement artistique. 🌟 Débuts et ascension En 1964, elle quitte sa ville natale pour s’installer à Alger, où elle entame une carrière de comédienne malgré des débuts difficiles. C’est dans le feuilleton télévisé « El Hariq » (L’Incendie), adapté du roman de Mohamed Dib et réalisé par Mustapha Badie, qu’elle se révèle au grand public. Son interprétation du personnage de « Lalla Aini » devient culte et lui vaut une reconnaissance nationale. 🎬 Carrière cinématographique Chafia Boudrâa a joué dans une douzaine de films marquants du cinéma algérien, parmi lesquels : L’Évasion de Hassan Terro de Mustapha Badie (1974) Une femme pour mon fils d’Ali Ghalem (1982) Le thé à la menthe d’Abdelkrim Bahloul (1984) Le mariage de Moussa de Tayeb Mefti Leila et les autres de Sid Ali Mazif Un vampire au paradis de Abdelkrim Bahloul Le cri des hommes de Okacha Touita Hors-la-loi de Rachid Bouchareb (2010), présenté en compétition officielle au Festival de Cannes, où elle incarne la mère des trois protagonistes. 📺 Télévision et théâtre Outre ses rôles au cinéma, elle a participé à plusieurs productions télévisées algériennes et françaises, dont : Sixième gauche de Claire Blangille Le Secret d’Elissa Rhaïs de Jacques Otmezguine L’un contre l’autre de Dominique Baron Just like a woman (2012) et L’honneur de ma famille de Rachid Bouchareb Au théâtre, elle a brillé dans des pièces comme La Mégère apprivoisée au Théâtre national d’Alger, où elle interprète le rôle de la veuve. Elle a également participé à un monologue poignant sur la condition féminine, mis en scène par Hamida Ait El Hadj. 🕊 Vie personnelle et hommage Veuve d’un chahid du Front de Libération National (FLN), tombé au combat en 1960, Chafia Boudrâa a toujours porté en elle les valeurs de dignité et de mémoire. Elle s’est éteinte le dimanche 22 mai 2022 à Alger, à l’âge de 92 ans. Son décès a suscité une vive émotion dans le monde artistique algérien. De nombreux hommages lui ont été rendus, notamment par le Théâtre national d’Alger, le Festival du film arabe d’Oran et le Festival du film de Mascate, saluant son immense contribution à la culture algérienne.', 1, '2025-10-17 08:51:49'),
(2, 18, 2, NULL, NULL, NULL, NULL, 1, '2025-10-07 19:04:54'),
(28, 8, 109, NULL, NULL, NULL, NULL, 1, '2025-10-14 12:43:07'),
(31, 21, 21, NULL, NULL, NULL, NULL, 1, '2025-10-19 16:45:24'),
(32, 22, 110, NULL, NULL, NULL, NULL, 1, '2025-10-22 07:46:41'),
(33, 22, 3, NULL, NULL, NULL, NULL, 2, '2025-10-22 07:46:41'),
(34, 22, 109, NULL, NULL, NULL, NULL, 3, '2025-10-22 07:46:41'),
(35, 23, 106, NULL, NULL, NULL, NULL, 1, '2025-10-22 10:12:59'),
(36, 46, 72, NULL, NULL, NULL, NULL, 1, '2025-10-23 15:14:32'),
(37, 47, NULL, 'Baya Belal', 'Actrice', 'img_emissions/baya_belal.jpeg', NULL, 1, '2025-10-23 16:26:40'),
(39, 48, 55, NULL, NULL, NULL, NULL, 1, '2025-10-23 16:45:53'),
(40, 48, NULL, 'Baya Belal', 'Actrice', 'img_emissions/baya_belal-1.jpeg', NULL, 1, '2025-10-23 17:54:10'),
(41, 32, NULL, 'Leila Mahzouz', 'Autre', 'img_emissions/leila_mazouz.jpg', NULL, 1, '2025-10-26 13:00:04'),
(42, 49, NULL, 'Baya Belal', 'Actrice', 'img_emissions/baya_belal.jpeg', NULL, 1, '2025-10-26 13:30:31'),
(43, 49, 55, NULL, NULL, NULL, NULL, 2, '2025-10-26 13:30:47'),
(44, 39, 112, NULL, NULL, NULL, NULL, 1, '2025-10-26 13:37:59'),
(45, 57, 109, NULL, NULL, NULL, NULL, 1, '2025-10-26 14:22:44'),
(46, 58, NULL, 'Samira', 'Animatrice', 'img_invites/logo.png', 'Animatrice Radio de Marseille', 1, '2025-10-26 14:34:32'),
(47, 59, NULL, 'Chafia Boudraa', 'Actrice', 'img_emissions/boudraa.png', NULL, 1, '2025-10-26 14:44:19');

-- --------------------------------------------------------

--
-- Structure de la table `emission_likes`
--

DROP TABLE IF EXISTS `emission_likes`;
CREATE TABLE IF NOT EXISTS `emission_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emission_id` int NOT NULL,
  `user_ip` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_like` (`emission_id`,`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `emission_ratings`
--

DROP TABLE IF EXISTS `emission_ratings`;
CREATE TABLE IF NOT EXISTS `emission_ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emission_id` int NOT NULL,
  `rating` int NOT NULL,
  `user_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_emission_ip` (`emission_id`,`user_ip`),
  KEY `idx_emission` (`emission_id`),
  KEY `idx_ip` (`user_ip`)
) ;

--
-- Déchargement des données de la table `emission_ratings`
--

INSERT INTO `emission_ratings` (`id`, `emission_id`, `rating`, `user_ip`, `created_at`) VALUES
(1, 18, 4, '::1', '2025-10-12 13:28:47'),
(3, 3, 4, '127.0.0.1', '2025-10-13 22:18:46'),
(4, 17, 3, '127.0.0.1', '2025-10-11 19:20:51'),
(5, 12, 5, '::1', '2025-10-12 13:28:13'),
(6, 6, 3, '::1', '2025-10-12 13:28:16'),
(7, 2, 5, '::1', '2025-10-12 13:28:19'),
(8, 7, 5, '::1', '2025-10-19 07:57:56'),
(9, 5, 4, '::1', '2025-10-12 13:28:24'),
(10, 4, 4, '::1', '2025-10-16 09:08:15'),
(11, 8, 5, '::1', '2025-10-12 13:28:29'),
(12, 9, 5, '::1', '2025-10-12 13:28:31'),
(13, 10, 4, '::1', '2025-10-12 13:28:32'),
(14, 13, 5, '::1', '2025-10-16 08:13:07'),
(15, 11, 5, '::1', '2025-10-12 13:28:36'),
(16, 1, 4, '::1', '2025-10-12 13:28:44'),
(17, 15, 4, '::1', '2025-10-12 13:28:45'),
(18, 16, 4, '::1', '2025-10-16 09:07:12'),
(19, 13, 5, '127.0.0.1', '2025-10-18 20:49:49'),
(20, 6, 5, 'rate_68f20dc53eda62.17439853', '2025-10-17 09:55:22'),
(21, 17, 5, 'rate_68f20dc53eda62.17439853', '2025-10-17 09:55:54'),
(26, 15, 5, 'rate_68f20dc53eda62.17439853', '2025-10-17 10:09:13'),
(31, 13, 5, 'rate_68f20dc53eda62.17439853', '2025-10-17 11:18:56'),
(33, 9, 5, 'rate_68f20dc53eda62.17439853', '2025-10-17 11:39:52'),
(36, 11, 5, NULL, '2025-10-17 15:20:09'),
(37, 3, 5, '::1', '2025-10-28 19:22:32'),
(38, 18, 5, NULL, '2025-10-17 15:30:22'),
(39, 13, 5, NULL, '2025-10-17 17:08:04'),
(40, 16, 5, 'rate_68f20dc53eda62.17439853', '2025-10-17 17:32:49'),
(41, 17, 5, NULL, '2025-10-17 17:49:00'),
(45, 3, 5, NULL, '2025-10-18 19:08:46'),
(46, 9, 4, '127.0.0.1', '2025-10-18 20:48:48'),
(47, 18, 5, NULL, '2025-10-19 07:55:35'),
(48, 3, 5, NULL, '2025-10-19 08:00:06'),
(51, 18, 5, NULL, '2025-10-19 08:05:12'),
(52, 16, 5, NULL, '2025-10-19 08:05:28'),
(54, 17, 5, NULL, '2025-10-19 08:07:24'),
(55, 18, 5, NULL, '2025-10-19 08:16:58'),
(56, 18, 5, NULL, '2025-10-19 08:18:35'),
(57, 18, 5, NULL, '2025-10-19 08:19:39'),
(58, 6, 5, NULL, '2025-10-19 09:46:48'),
(59, 10, 5, NULL, '2025-10-19 10:37:12'),
(60, 4, 5, NULL, '2025-10-19 11:39:50'),
(61, 21, 5, '::1', '2025-10-19 16:09:14'),
(64, 21, 5, NULL, '2025-10-19 16:44:38'),
(67, 1, 5, '127.0.0.1', '2025-10-20 15:02:58'),
(69, 5, 5, '127.0.0.1', '2025-10-20 15:48:53'),
(72, 22, 5, '127.0.0.1', '2025-10-22 08:56:51'),
(75, 44, 4, '127.0.0.1', '2025-10-24 01:05:36'),
(77, 46, 3, '127.0.0.1', '2025-10-24 23:17:45'),
(78, 42, 3, '127.0.0.1', '2025-10-24 23:17:53'),
(79, 45, 3, '127.0.0.1', '2025-10-24 23:18:09'),
(80, 37, 3, '127.0.0.1', '2025-10-24 23:18:16'),
(81, 38, 5, '127.0.0.1', '2025-10-24 23:18:26'),
(82, 23, 4, '127.0.0.1', '2025-10-24 23:18:35'),
(83, 34, 3, '127.0.0.1', '2025-10-24 23:18:42'),
(84, 32, 3, '127.0.0.1', '2025-10-24 23:18:51'),
(85, 40, 3, '127.0.0.1', '2025-10-24 23:19:02'),
(86, 36, 3, '127.0.0.1', '2025-10-24 23:19:07'),
(87, 41, 3, '127.0.0.1', '2025-10-24 23:19:13'),
(88, 33, 3, '127.0.0.1', '2025-10-24 23:19:20'),
(89, 39, 5, '127.0.0.1', '2025-10-24 23:19:26'),
(90, 25, 3, '127.0.0.1', '2025-10-24 23:19:44'),
(91, 29, 3, '127.0.0.1', '2025-10-24 23:19:52'),
(92, 28, 3, '127.0.0.1', '2025-10-24 23:19:58'),
(93, 26, 3, '127.0.0.1', '2025-10-24 23:20:04'),
(94, 27, 3, '127.0.0.1', '2025-10-24 23:20:08'),
(95, 43, 3, '127.0.0.1', '2025-10-24 23:20:18'),
(96, 31, 4, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:06'),
(97, 53, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:23'),
(98, 54, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:27'),
(99, 52, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:33'),
(100, 51, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:37'),
(101, 50, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:42'),
(102, 49, 4, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:46'),
(103, 59, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:29:56'),
(104, 58, 4, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:12'),
(105, 57, 4, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:16'),
(106, 56, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:22'),
(107, 55, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:29'),
(108, 30, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:37'),
(109, 35, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:42'),
(110, 60, 3, 'rate_68f20dc53eda62.17439853', '2025-10-27 11:30:54'),
(112, 44, 5, '::1', '2025-10-28 19:22:50'),
(113, 60, 5, '::1', '2025-10-28 19:22:53'),
(114, 25, 4, '::1', '2025-10-28 22:24:15'),
(116, 28, 5, '::1', '2025-10-30 16:26:57'),
(117, 51, 4, '127.0.0.1', '2025-11-02 22:36:31'),
(119, 50, 4, '::1', '2025-11-03 11:25:40'),
(120, 29, 5, '::1', '2025-11-03 12:05:29'),
(123, 26, 5, '::1', '2025-11-03 12:05:58'),
(126, 55, 4, NULL, '2025-11-03 13:44:41'),
(127, 55, 4, NULL, '2025-11-03 13:44:50'),
(128, 55, 4, NULL, '2025-11-03 13:44:55'),
(129, 56, 4, NULL, '2025-11-03 13:45:04'),
(130, 33, 4, NULL, '2025-11-03 15:24:31'),
(131, 50, 5, NULL, '2025-11-03 15:25:29'),
(132, 17, 5, NULL, '2025-11-03 16:01:27'),
(133, 17, 5, NULL, '2025-11-03 16:01:41'),
(134, 33, 5, NULL, '2025-11-05 12:49:27'),
(135, 39, 5, NULL, '2025-11-05 12:49:40'),
(136, 40, 4, NULL, '2025-11-05 13:20:49'),
(137, 36, 4, NULL, '2025-11-05 13:27:32'),
(138, 44, 5, NULL, '2025-11-05 16:06:46'),
(139, 55, 4, NULL, '2025-11-05 17:22:33'),
(140, 57, 5, NULL, '2025-11-05 18:20:11'),
(141, 57, 5, NULL, '2025-11-05 18:20:13'),
(142, 58, 5, NULL, '2025-11-05 18:21:24'),
(143, 29, 4, NULL, '2025-11-05 19:11:32'),
(144, 38, 4, NULL, '2025-11-05 19:13:29'),
(145, 38, 5, NULL, '2025-11-05 19:13:31'),
(146, 37, 5, NULL, '2025-11-05 19:13:34'),
(147, 34, 4, NULL, '2025-11-05 19:13:37'),
(149, 43, 5, '::1', '2025-11-06 15:04:06'),
(150, 46, 4, '::1', '2025-11-06 15:08:27'),
(153, 27, 5, '::1', '2025-11-07 11:12:30'),
(154, 18, 5, NULL, '2025-11-07 11:25:35'),
(155, 59, 4, NULL, '2025-11-07 11:25:40'),
(156, 52, 4, '::1', '2025-11-07 11:28:51'),
(157, 57, 3, NULL, '2025-11-07 15:48:26'),
(158, 46, 4, NULL, '2025-11-07 17:02:05'),
(159, 60, 4, NULL, '2025-11-07 17:08:20'),
(160, 1, 4, NULL, '2025-11-07 17:14:02'),
(161, 60, 4, NULL, '2025-11-07 17:14:35'),
(162, 26, 4, NULL, '2025-11-07 17:15:32'),
(163, 28, 4, NULL, '2025-11-07 17:16:00'),
(164, 28, 4, NULL, '2025-11-07 17:17:23'),
(165, 44, 5, NULL, '2025-11-08 20:13:58'),
(166, 26, 4, NULL, '2025-11-08 20:19:44'),
(167, 29, 4, NULL, '2025-11-08 20:20:02'),
(168, 41, 5, '::1', '2025-11-09 15:08:50'),
(169, 17, 5, '::1', '2025-11-09 19:17:10'),
(170, 17, 5, NULL, '2025-11-10 16:36:03'),
(171, 49, 5, NULL, '2025-11-10 16:37:28'),
(172, 17, 5, NULL, '2025-11-10 17:33:31'),
(173, 40, 5, NULL, '2025-11-10 17:33:41'),
(174, 22, 5, '::1', '2025-11-10 18:02:28'),
(176, 31, 5, '::1', '2025-11-10 18:45:40'),
(178, 33, 4, '::1', '2025-11-12 12:43:50'),
(179, 59, 5, '::1', '2025-11-12 14:52:22'),
(180, 51, 5, '::1', '2025-11-13 12:49:18'),
(185, 60, 5, '127.0.0.1', '2025-11-19 16:59:16'),
(199, 57, 5, '::1', '2026-02-08 08:00:27'),
(200, 35, 5, '::1', '2026-02-08 08:21:49'),
(211, 36, 4, '::1', '2026-02-09 19:51:57');

-- --------------------------------------------------------

--
-- Structure de la table `emission_views`
--

DROP TABLE IF EXISTS `emission_views`;
CREATE TABLE IF NOT EXISTS `emission_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emission_id` int NOT NULL,
  `user_ip` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `viewed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_view` (`emission_id`,`user_ip`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emission_views`
--

INSERT INTO `emission_views` (`id`, `emission_id`, `user_ip`, `viewed_at`) VALUES
(1, 25, '::1', '2026-01-28 13:33:04');

-- --------------------------------------------------------

--
-- Structure de la table `interviews`
--

DROP TABLE IF EXISTS `interviews`;
CREATE TABLE IF NOT EXISTS `interviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artiste_nom` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `artiste_id` int NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `audio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie_id` int NOT NULL,
  `views` int NOT NULL DEFAULT '0',
  `likes` int NOT NULL DEFAULT '0',
  `date_interview` datetime DEFAULT NULL COMMENT 'la date de l''interview',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `artist_id` (`artiste_id`),
  KEY `category_id` (`categorie_id`),
  KEY `idx_interviews_views` (`views`),
  KEY `idx_interviews_date_interview` (`date_interview`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `interviews`
--

INSERT INTO `interviews` (`id`, `artiste_nom`, `user_id`, `artiste_id`, `image`, `audio`, `categorie_id`, `views`, `likes`, `date_interview`) VALUES
(1, 'ABDELKADER CHERCHAM', 4, 3, 'img_interviews/abdelkader chercham.png', 'audio_interviews/abdelkader chercham.mp3', 5, 50, 154, '2000-07-16 16:56:04'),
(2, 'Abdelkader Chaou', 4, 2, 'img_interviews/chaou_mah.jpg', 'audio_interviews/abdelkader_chaou.mp3', 5, 53, 152, '2000-03-17 17:22:15'),
(3, 'Abdelmadjid Maskoud', 4, 5, 'img_interviews/meskoud.jpg', 'audio_interviews/abdelmadjid meskoud.mp3', 5, 26, 151, '2000-03-15 17:24:57'),
(4, 'Abderahmane Elkoubi', 4, 8, 'img_interviews/Abderrahmane El-Kobbi.jpeg', 'audio_interviews/abdelrahman koubi.mp3', 5, 151, 151, '2000-07-15 17:26:43'),
(5, 'aziouz Rais', 4, 14, 'img_interviews/rais_djaafri_mah.jpg', 'audio_interviews/aziouz rais.mp3', 5, 25, 151, '2000-03-19 17:27:47'),
(6, 'Dilem', 4, 82, 'img_interviews/dilem.png', 'audio_interviews/dilem.mp3', 5, 16, 151, '2000-03-17 17:29:44'),
(7, 'Djaafar Benyoucef', 4, 81, 'img_interviews/djaffar.jpg', 'audio_interviews/djaafar benyoucef.mp3', 5, 30, 151, '2000-03-17 17:31:41'),
(8, 'El hachemi Guerouabi', 4, 21, 'img_interviews/emi011.gif', 'audio_interviews/el hachemi guerouabi.mp3', 5, 37, 152, '2003-01-20 20:00:00'),
(9, 'el hadi elanka', 4, 96, 'img_interviews/hadi_mah.jpg', 'audio_interviews/el hadi el anka.mp3', 5, 18, 151, '2000-03-17 10:40:32'),
(10, 'HAMID BEDJAOUI', 4, 33, 'img_interviews/bedjaoui.jpg', 'audio_interviews/hamid bedjaoui.mp3', 5, 26, 151, '2000-03-15 10:42:49'),
(11, 'HASSEN SAID', 4, 35, 'img_interviews/said1.gif', 'audio_interviews/hassen said.mp3', 5, 15, 152, '2024-05-29 10:44:43'),
(12, 'KAMEL EL HARRACHI', 4, 83, 'img_interviews/mahkamel.jpg', 'audio_interviews/kamel el harrachi.mp3', 5, 14, 151, '2000-03-18 10:53:07'),
(13, 'MBS', 4, 84, 'img_interviews/mbs.jpg', 'audio_interviews/mbs.mp3', 5, 14, 151, '2000-03-17 10:54:01'),
(14, 'MOHAMED LAMRAOUI', 4, 85, 'img_interviews/lamraoui_mah.jpg', 'audio_interviews/mohamed lamraoui.mp3', 5, 15, 151, '2024-05-29 11:59:37'),
(15, 'MOHAMED ELBADJI', 4, 47, 'img_interviews/badji_mahfoud.png', 'audio_interviews/mohamed_elbadji.mp3', 5, 29, 153, '2000-05-15 12:01:04'),
(16, 'MOURADE DJAAFRI', 4, 49, 'img_interviews/djaafri_mah.jpg', 'audio_interviews/mourade djaafri.mp3', 5, 26, 151, '2000-03-19 12:01:43'),
(17, 'NACER AYA', 4, 86, 'img_interviews/nacer_aya_p.jpeg', 'audio_interviews/nacer aya.mp3', 5, 13, 151, '2000-03-17 12:03:52'),
(18, 'NACERDINE GALIZE', 4, 87, 'img_interviews/galiz_mah.jpg', 'audio_interviews/nacerdine galize.mp3', 5, 17, 152, '2024-05-29 12:05:37'),
(19, 'NADIA BENYOUCEF', 4, 55, 'img_interviews/nadia.jpg', 'audio_interviews/nadia benyoucef.mp3', 5, 18, 151, '2024-05-29 12:06:41'),
(21, 'NAIMA ABABSA', 4, 88, 'img_interviews/naima-ababssa.png', 'audio_interviews/naima ababsa.mp3', 5, 39, 152, '2024-05-29 13:15:59'),
(22, 'RADIA ADDA', 4, 65, 'img_interviews/radia_mah.jpg', 'audio_interviews/radia adda.mp3', 5, 45, 154, '2000-07-27 13:28:36'),
(23, 'SID ALI DJIRI', 4, 89, 'img_interviews/dziri.jpg', 'audio_interviews/sid ali djiri.mp3', 5, 35, 153, '2024-05-29 13:31:49'),
(24, 'SID ALI DRIS', 4, 90, 'img_interviews/driss.jpg', 'audio_interviews/sid ali dris.mp3', 5, 42, 155, '2024-05-29 13:34:04'),
(25, 'DAGHFALI ZERROUK', 4, 91, 'img_interviews/daghefali.gif', 'audio_interviews/zerrouk daghfali.mp3', 5, 65, 158, '2000-07-16 13:36:38'),
(26, 'El hadj elhachemi Guerouabi', 4, 21, 'img_interviews/guerouabi.jpg', 'audio_interviews/interview_elhachemi_guerouabi_41e_20-01-2003.mp3', 5, 155, 151, '2003-01-20 18:00:00'),
(27, 'Chafia Boudraa', 4, 108, 'img_interviews/boudraa.png', 'audio_interviews/interview_chafia boudraa 9e_1-04-02.mp3', 5, 158, 151, '2002-04-01 19:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ip_time` (`ip`,`created_at`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `ip`, `username`, `created_at`) VALUES
(1, '::1', NULL, '2025-09-16 12:06:05'),
(2, '::1', NULL, '2025-09-16 12:06:10'),
(3, '::1', NULL, '2025-09-16 12:06:19'),
(4, '::1', NULL, '2025-09-16 12:06:21'),
(5, '::1', NULL, '2025-09-16 12:06:38'),
(6, '::1', NULL, '2025-09-16 12:07:30'),
(7, '::1', 'admin@chaabi.com', '2025-09-16 13:05:12'),
(8, '::1', 'admin@chaabi.com', '2025-09-16 13:06:19'),
(9, '::1', 'Mahfoud', '2025-09-16 13:09:51'),
(10, '::1', 'admin', '2025-09-16 13:14:21'),
(11, '::1', 'admin@chaabi.com', '2025-09-16 13:14:31'),
(12, '::1', 'webchaabidialna@gmail.com', '2025-10-06 16:02:14'),
(13, '::1', 'chaabi.dialna@gmail.com', '2025-10-06 16:02:49'),
(14, '::1', 'chaabi.dialna@gmail.com', '2025-10-06 16:03:34'),
(15, '::1', 'chaabi.dialna@gmail.com', '2025-10-06 16:04:27'),
(16, '::1', 'chaabi.dialna@gmail.com', '2025-10-06 21:28:40'),
(17, '::1', 'chaabi.dialna@gmail.com', '2025-10-07 14:11:46'),
(18, '::1', 'chaabi.dialna@gmail.com', '2025-10-23 09:59:49'),
(19, '::1', 'chaabi.dialna@gmail.com', '2025-10-24 14:49:58'),
(20, '::1', 'chaabi.dialna@gmail.com', '2025-11-03 14:29:51');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','user','moderator') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `email`, `password`, `image`, `role`, `created_at`) VALUES
(8, 'adam', 'admin@chaabi.com', '$2y$10$XbDbiXHpcWfyCZYjdljpd.7IGZ9NDm6V6RBjwftPH85fh7aCdDVDa', 'img_users/adam.jpeg', 'admin', '2025-08-12 12:00:24'),
(4, 'Mahfoud', 'chaabi.dialna@gmail.com', '$2y$10$Kj9PptDtXccroFAc4cG7EuNkWmLrAaBOWKJwT6DzsHjqXRmvlxvPS', 'img_artistes/Mahfoud.png', 'admin', '2025-08-18 13:55:02');

-- --------------------------------------------------------

--
-- Structure de la table `user_interactions`
--

DROP TABLE IF EXISTS `user_interactions`;
CREATE TABLE IF NOT EXISTS `user_interactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `item_id` int NOT NULL,
  `item_type` enum('song','emission','interview','artist') NOT NULL,
  `action` enum('increment_view','increment_like') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_interaction` (`user_id`,`item_id`,`item_type`,`action`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user_interactions`
--

INSERT INTO `user_interactions` (`id`, `user_id`, `item_id`, `item_type`, `action`, `created_at`) VALUES
(1, 0, 3, 'emission', 'increment_view', '2025-10-17 12:18:24'),
(2, 0, 13, 'emission', 'increment_view', '2025-10-17 12:18:24'),
(3, 0, 11, 'emission', 'increment_view', '2025-10-17 12:18:25'),
(4, 0, 13, 'emission', 'increment_like', '2025-10-17 12:18:29'),
(5, 0, 10, 'emission', 'increment_view', '2025-10-30 12:46:46'),
(6, 0, 9, 'emission', 'increment_view', '2025-10-17 12:18:32'),
(7, 0, 8, 'emission', 'increment_view', '2025-10-17 12:18:32'),
(8, 0, 7, 'emission', 'increment_view', '2025-10-17 12:18:33'),
(9, 0, 5, 'emission', 'increment_view', '2025-10-17 12:18:33'),
(10, 0, 4, 'emission', 'increment_view', '2025-10-17 12:18:33'),
(11, 0, 2, 'emission', 'increment_view', '2025-10-17 12:18:33'),
(12, 0, 6, 'emission', 'increment_view', '2025-10-17 12:18:37'),
(13, 0, 12, 'emission', 'increment_view', '2025-10-17 12:18:37'),
(14, 0, 1, 'emission', 'increment_view', '2025-10-17 12:18:37'),
(15, 0, 44, 'emission', 'increment_view', '2025-10-30 12:35:57'),
(17, 0, 44, 'emission', 'increment_like', '2025-10-30 12:47:16'),
(18, 0, 17, 'emission', 'increment_view', '2025-10-30 13:21:42'),
(19, 0, 17, 'emission', 'increment_like', '2025-10-30 13:21:46'),
(20, 0, 52, 'emission', 'increment_like', '2025-10-30 13:25:38'),
(21, 0, 51, 'emission', 'increment_like', '2025-10-30 13:25:42'),
(22, 2147483647, 60, 'emission', 'increment_like', '2025-10-30 15:16:11'),
(24, 2147483647, 22, 'emission', 'increment_like', '2025-10-30 15:20:11'),
(25, 1, 27, 'emission', 'increment_view', '2025-10-30 16:19:54'),
(26, 1, 28, 'emission', 'increment_like', '2025-10-30 16:26:52'),
(27, 1, 3, 'emission', 'increment_view', '2025-10-30 16:38:18'),
(28, 1, 44, 'emission', 'increment_view', '2025-10-30 16:58:49'),
(29, 1, 10, 'emission', 'increment_view', '2025-10-30 17:18:22'),
(30, 0, 60, 'emission', 'increment_view', '2025-11-05 14:34:19'),
(31, 0, 59, 'emission', 'increment_view', '2025-11-05 14:34:36'),
(32, 0, 21, 'emission', 'increment_view', '2025-11-05 14:34:55'),
(33, 0, 22, 'emission', 'increment_view', '2025-11-05 14:39:51'),
(34, 0, 18, 'emission', 'increment_view', '2025-11-05 19:44:28'),
(35, 0, 45, 'emission', 'increment_like', '2025-11-05 19:48:17'),
(40, 0, 41, 'emission', 'increment_view', '2025-11-06 16:00:45'),
(42, 0, 31, 'emission', 'increment_view', '2025-11-07 10:35:10'),
(43, 0, 25, 'emission', 'increment_view', '2025-11-07 11:12:26'),
(45, 0, 57, 'emission', 'increment_view', '2025-11-07 11:28:36'),
(46, 0, 58, 'emission', 'increment_view', '2025-11-07 11:28:40'),
(47, 0, 52, 'emission', 'increment_view', '2025-11-07 11:28:51'),
(54, 0, 53, 'emission', 'increment_view', '2025-11-07 11:28:59'),
(55, 0, 53, 'emission', 'increment_like', '2025-11-07 11:28:59'),
(124, 0, 51, 'emission', 'increment_view', '2025-11-07 11:29:08'),
(147, 0, 28, 'emission', 'increment_view', '2025-11-07 16:03:07'),
(148, 0, 109, '', 'increment_view', '2026-04-05 21:47:48'),
(149, 0, 72, '', 'increment_view', '2026-04-05 21:48:05'),
(150, 0, 3, '', 'increment_view', '2026-04-05 21:49:10');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `artistes`
--
ALTER TABLE `artistes` ADD FULLTEXT KEY `idx_artistes_bio` (`bio`);
ALTER TABLE `artistes` ADD FULLTEXT KEY `idx_artistes_nom` (`nom`);
ALTER TABLE `artistes` ADD FULLTEXT KEY `idx_artistes_nom_bio` (`nom`,`bio`);

--
-- Index pour la table `chansons`
--
ALTER TABLE `chansons` ADD FULLTEXT KEY `idx_chansons_titre` (`titre`);

--
-- Index pour la table `dedicaces`
--
ALTER TABLE `dedicaces` ADD FULLTEXT KEY `idx_dedicaces_description` (`description`);
ALTER TABLE `dedicaces` ADD FULLTEXT KEY `idx_dedicaces_nom_pour` (`nom`,`pour`);
ALTER TABLE `dedicaces` ADD FULLTEXT KEY `idx_dedicaces_nom_pour_description` (`nom`,`pour`,`description`);

--
-- Index pour la table `emissions`
--
ALTER TABLE `emissions` ADD FULLTEXT KEY `idx_emissions_description` (`description`);
ALTER TABLE `emissions` ADD FULLTEXT KEY `idx_emissions_titre` (`titre`);
ALTER TABLE `emissions` ADD FULLTEXT KEY `idx_emissions_titre_description` (`titre`,`description`);

--
-- Index pour la table `interviews`
--
ALTER TABLE `interviews` ADD FULLTEXT KEY `idx_interviews_artiste_nom` (`artiste_nom`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `emission_comments`
--
ALTER TABLE `emission_comments`
  ADD CONSTRAINT `emission_comments_ibfk_1` FOREIGN KEY (`emission_id`) REFERENCES `emissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `emission_likes`
--
ALTER TABLE `emission_likes`
  ADD CONSTRAINT `emission_likes_ibfk_1` FOREIGN KEY (`emission_id`) REFERENCES `emissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `emission_ratings`
--
ALTER TABLE `emission_ratings`
  ADD CONSTRAINT `emission_ratings_ibfk_1` FOREIGN KEY (`emission_id`) REFERENCES `emissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `emission_views`
--
ALTER TABLE `emission_views`
  ADD CONSTRAINT `emission_views_ibfk_1` FOREIGN KEY (`emission_id`) REFERENCES `emissions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
