#! /usr/bin/env bash

echo "Line count (scripts)"
find scripts/ -name '*.js' | xargs wc -l | sort

echo "Line count (test)"
find test/ -name '*.js' | xargs wc -l | sort

echo "Ember.run count (scripts)"
grep Ember.run -rC 0 scripts/ | wc -l;

echo "Ember.run count (test)"
grep Ember.run -rC 0 test/ | wc -l;

echo "Ember.observes count (scripts)"
grep '.observes(' -rC 0 scripts/ | wc -l;

echo "Ember.observes count (tests)"
grep '.observes(' -rC 0 test/ | wc -l;

echo "Ember.lookup count (scripts)"
grep 'lookup' -rC 0 scripts/ | wc -l;

