# Manages operations on course directories:
# 1. Builds `new` course scaffolds on demand (i.e. from logstudytime -c) when
# called with `make new course=[course_name]`
# 2. ?

ROOT		:=$(realpath ..)# Repo root 'studies'
COURSES_DIR :=$(ROOT)/courses
NAME		:=$(COURSES_DIR)/$(course)
COURSES		:=$(shell find $(COURSES_DIR)/ -maxdepth 1 -type d -not -name courses | xargs basename -a)

.PHONY:
	all
	new

all: new

# Abort with message if course exists.
#
# Note: This matches any substring within
# COURSES, meaning that progressive naming causes conflicts.
# i.e. trying to create `example` after `example_lastsemester` would not work.
# To counter this, use unique names for your courses, as they surely have such.
ifneq (,$(findstring $(course),$(COURSES)))
new:
	$(error `$(course)` already exists, or the name conflicts with an existing course (see README: Naming conventions))
else ifeq (,$(course))
new:
	$(info Please provide a course name (course=[coursename]))
else
new:
	@mkdir $(NAME)
	@mkdir $(NAME)/assets
	@mkdir $(NAME)/exercises
	@touch $(NAME)/dates.md
	@touch $(NAME)/notes.md
	@touch $(NAME)/time.csv
endif
