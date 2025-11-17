-- Remove dangling references to nodes filtered out by the bulk load snapshot

-- Drop forums referencing nonexistent moderators
DELETE FROM Forum
WHERE hasModerator_Person NOT IN (SELECT id FROM Person);

-- Ensure forum relations reference existing forums/persons/tags
DELETE FROM Forum_hasMember_Person
WHERE hasMember_Person NOT IN (SELECT id FROM Person)
   OR id NOT IN (SELECT id FROM Forum);

DELETE FROM Forum_hasTag_Tag
WHERE id NOT IN (SELECT id FROM Forum)
   OR hasTag_Tag NOT IN (SELECT id FROM Tag);

DELETE FROM Post
WHERE hasCreator_Person NOT IN (SELECT id FROM Person);

DELETE FROM Post
WHERE Forum_containerOf NOT IN (SELECT id FROM Forum);

DELETE FROM Comment
WHERE hasCreator_Person NOT IN (SELECT id FROM Person);

-- Ensure comment/post tag rels reference existing rows
DELETE FROM Comment_hasTag_Tag
WHERE id NOT IN (SELECT id FROM Comment)
   OR hasTag_Tag NOT IN (SELECT id FROM Tag);

DELETE FROM Post_hasTag_Tag
WHERE id NOT IN (SELECT id FROM Post)
   OR hasTag_Tag NOT IN (SELECT id FROM Tag);

DELETE FROM Comment
WHERE replyOf_Post IS NOT NULL AND replyOf_Post NOT IN (SELECT id FROM Post);

DELETE FROM Comment
WHERE replyOf_Comment IS NOT NULL AND replyOf_Comment NOT IN (SELECT id FROM Comment);

DELETE FROM Person_hasInterest_Tag
WHERE id NOT IN (SELECT id FROM Person)
   OR hasInterest_Tag NOT IN (SELECT id FROM Tag);

DELETE FROM Person_knows_Person
WHERE Person1id NOT IN (SELECT id FROM Person)
   OR Person2id NOT IN (SELECT id FROM Person);

DELETE FROM Person_likes_Comment
WHERE id NOT IN (SELECT id FROM Person)
   OR likes_Comment NOT IN (SELECT id FROM Comment);

DELETE FROM Person_likes_Post
WHERE id NOT IN (SELECT id FROM Person)
   OR likes_Post NOT IN (SELECT id FROM Post);

DELETE FROM Person_studyAt_University
WHERE id NOT IN (SELECT id FROM Person)
   OR studyAt_University NOT IN (SELECT id FROM University);

DELETE FROM Person_workAt_Company
WHERE id NOT IN (SELECT id FROM Person)
   OR workAt_Company NOT IN (SELECT id FROM Company);
