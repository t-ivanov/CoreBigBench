--For all products, extract sentences from its product reviews that con-
--tain Positive or Negative sentiment and display the sentiment polarity of the
--extracted sentences.

-- Resources
ADD JAR opennlp-maxent-3.0.3.jar;
ADD JAR opennlp-tools-1.5.3.jar;
ADD JAR bigbenchqueriesmr.jar;
CREATE TEMPORARY FUNCTION extract_sentiment AS 'de.bankmark.bigbench.queries.q10.SentimentUDF';
-- set the database
use BigBenchV2;


SELECT extract_sentiment(pr_item_id, pr_content) AS (pr_item_id, review_sentence, sentiment, sentiment_word)
FROM (
  SELECT 
	pr_item_id,
	pr_content 
  FROM 
	product_reviews DISTRIBUTE BY length(pr_content)
) pr;


--  Time taken: 103.319 seconds, Fetched: 775540 row(s)

