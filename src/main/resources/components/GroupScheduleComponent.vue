<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-expansion-panel>
        <v-expansion-panel-content>
            <template v-slot:header>
                <div>Group Schedule</div>
            </template>
            <v-container>
                <v-layout style="margin-bottom: 20px;">
                    <v-radio-group v-model="calendarView" row>
                        <v-radio :key="1" :label="'Calendar'" :value="true"></v-radio>
                        <v-radio :key="2" :label="'List'" :value="false"></v-radio>
                    </v-radio-group>
                    <v-spacer></v-spacer>
                    <v-btn color="info" v-on:click="addLesson" v-if="userCanAddLesson()">Add lesson</v-btn>
                </v-layout>
                <!--        buttons-->
                <v-layout style="margin-bottom: 20px">
                    <v-flex sm4 xs12 class="text-sm-left text-xs-center">
                        <v-btn @click="$refs.calendar.prev()">
                            <v-icon dark left>
                                keyboard_arrow_left
                            </v-icon>
                            Prev
                        </v-btn>
                    </v-flex>
                    <v-flex sm4 xs12 class="text-xs-center">
                        <h2>{{currentMonth}}</h2>
                    </v-flex>
                    <v-flex sm4 xs12 class="text-sm-right text-xs-center">
                        <v-btn @click="$refs.calendar.next()">
                            Next
                            <v-icon right dark>
                                keyboard_arrow_right
                            </v-icon>
                        </v-btn>
                    </v-flex>
                </v-layout>

                <div v-show="calendarView">
                    <!--        calendar-->
                    <v-layout>
                        <v-flex>
                            <v-sheet height="500">
                                <v-calendar
                                        color="primary"
                                        ref="calendar"
                                        v-model="start">
                                    <template v-slot:day="{ date }">
                                        <template v-for="lesson in lessonsMap[date]">
                                            <v-menu :key="lesson.id" v-model="lesson.open" full-width offset-x>
                                                <template v-slot:activator="{ on }">
                                                    <div
                                                            v-ripple
                                                            class="my-lesson"
                                                            v-bind:class="{ 'active-lesson': !lesson.isCanceled  , 'canceled-lesson': lesson.isCanceled }"
                                                            v-on="on"
                                                            v-html="lesson.topic"
                                                    >
                                                    </div>
                                                </template>
                                                <v-card color="grey lighten-4" min-width="350px" flat>
                                                    <v-toolbar color="primary" dark>
                                                        <h3>{{computedTime(lesson.timeDate.substr(11, 5))}}</h3>
                                                        <v-spacer></v-spacer>
                                                        <v-btn v-if="userCanEdit(lesson)" icon
                                                               v-on:click="editLesson(lesson)">
                                                            <v-icon>edit</v-icon>
                                                        </v-btn>
                                                        <v-btn flat v-on:click="forwardToLessonPage(lesson.id)" icon>
                                                            <v-icon>arrow_forward</v-icon>
                                                        </v-btn>
                                                    </v-toolbar>
                                                    <v-card-title primary-title>
                                                        <span>{{lesson.topic}}</span>
                                                    </v-card-title>
                                                    <v-card-text>
                                                        <span>{{lesson.trainerName}}</span>
                                                    </v-card-text>
                                                    <v-card-actions>
                                                        <v-btn v-if="userCanEdit(lesson)" flat color="secondary"
                                                               v-on:click="cancelLesson(lesson)">
                                                            <span v-if="lesson.isCanceled">Activate</span>
                                                            <span v-else>cancel</span>
                                                        </v-btn>
                                                        <v-spacer></v-spacer>
                                                    </v-card-actions>
                                                </v-card>
                                            </v-menu>
                                        </template>
                                    </template>
                                </v-calendar>
                            </v-sheet>
                        </v-flex>
                    </v-layout>
                </div>

                <div v-show="!calendarView">
                    <div v-if="lessonsMapMonthlyGrouped[startMonth] == undefined" class="text-xs-center">No lessons this
                        month
                    </div>
                    <div v-for="(lesson, index) in lessonsMapMonthlyGrouped[startMonth]">
                        <v-divider
                                :key="index" inset
                        ></v-divider>
                        <v-card class="mx-auto card">
                            <v-card-title
                                    v-bind:class="{ 'active-lesson': !lesson.isCanceled  , 'canceled-lesson': lesson.isCanceled }">
                                <span class="title font-weight-light">{{getDate(lesson.timeDate) + ' '+ computedTime(lesson.timeDate.substr(11, 5))}}</span>
                            </v-card-title>

                            <v-card-text class="headline font-weight-bold">
                                <div style="margin-bottom: 20px">{{lesson.topic}}</div>
                                <v-divider></v-divider>
                                <div class="text-xs-left">
                                    <v-chip v-for="attachment in lesson.attachments" :key="attachment.id">
                                        {{attachment.description}}
                                    </v-chip>
                                </div>
                            </v-card-text>

                            <v-card-actions>
                                <v-list-tile class="grow">
                                    <v-list-tile-content>
                                        <v-list-tile-title>{{lesson.trainerName}}</v-list-tile-title>
                                    </v-list-tile-content>
                                    <v-layout align-center justify-end>
                                        <v-btn flat color="secondary" v-on:click="cancelLesson(lesson)"
                                               v-if="userCanEdit(lesson)">
                                            <span v-if="lesson.isCanceled">Activate</span>
                                            <span v-else>cancel</span>
                                        </v-btn>
                                        <span class="mr-1">·</span>
                                        <v-btn v-if="userCanEdit(lesson)" flat v-on:click="editLesson(lesson)">
                                            <span>edit</span>
                                        </v-btn>
                                        <v-btn flat v-on:click="forwardToLessonPage(lesson.id)">
                                            <v-icon>arrow_forward</v-icon>
                                        </v-btn>
                                    </v-layout>
                                </v-list-tile>
                            </v-card-actions>
                        </v-card>
                    </div>
                </div>

                <lesson-editing-component ref='form' style="margin-bottom: 20px" v-if="editing" @saving-event="save"
                                          @delete-event="deleteLesson"
                                          @cancel-event="cancel"
                                          :attachments="allAttachments" :currentLesson="currentEditingLesson"
                                          :trainers="allTrainers"
                                          :courseTrainerId="courseTrainerId"></lesson-editing-component>
            </v-container>
        </v-expansion-panel-content>
    </v-expansion-panel>
</template>

<script>
    import axios from 'axios/index';
    import LessonEditingComponent from './LessonEditingComponent.vue';

    export default {
        name: "GroupSchedulePage",
        data: function () {
            return {
                group: [],
                lessons: [],
                currentEditingLesson: {},
                start: new Date().toISOString().slice(0, 10),
                editing: false,
                allTrainers: [],
                allAttachments: [],
                calendarView: true
            }
        },
        props: ['isStudentOfGroup', 'courseTrainerId'],
        mounted() {
            let self = this;
            let id = this.$route.params.id;
            axios.get(this.$store.state.apiServer + '/api/schedule/' + self.$route.params.id)
                .then(function (response) {
                    self.lessons = response.data;
                    console.log("lessons from back");
                    console.log(self.lessons);
                    self.lessons.forEach(function (one) {
                        one.open = false;
                    })
                })
                .catch(function (error) {
                    console.log(error);
                    if (error.response != null && error.response.status == 400)
                        self.$router.push('/404');
                    // self.errorAutoClosable(error.response.data);
                });
            axios.get(this.$store.state.apiServer + '/api/desired-schedule/' + self.$route.params.id)
                .then(function (response) {
                    self.group = response.data;
                    self.loadAdditional(id);
                })
                .catch(function (error) {
                    console.log(error);
                    if (error.response != null && error.response.status == 400)
                        self.$router.push('/404');
                    // self.errorAutoClosable(error.response.data);
                });
            axios.get(this.$store.state.apiServer + '/api/users/get-all-trainers')
                .then(function (response) {
                    self.allTrainers = response.data;
                })
                .catch(function (error) {
                    console.log(error);
                    if (error.response != null && error.response.status == 400)
                        self.$router.push('/404');
                    // self.errorAutoClosable(error.response.data);
                });
            axios.get(this.$store.state.apiServer + '/api/attachments/all')
                .then(function (response) {
                    self.allAttachments = response.data;
                })
                .catch(function (error) {
                    console.log(error);
                    if (error.response != null && error.response.status == 400)
                        self.$router.push('/404');
                    // self.errorAutoClosable(error.response.data);
                });
        },
        computed: {
            filteredLessons() {
                let self = this;
                let filteredLessons = [];
                if (this.$store.state.userRoles.includes('ADMIN') ||
                    parseInt(this.$store.state.user.id) === parseInt(this.courseTrainerId) ||
                    this.isStudentOfGroup) {
                    filteredLessons = this.lessons
                } else {
                    filteredLessons = this.lessons.filter(function (e) {
                        return parseInt(e.trainerId) === parseInt(self.$store.state.user.id);
                    })
                }
                return filteredLessons;
            },
            lessonsMap() {
                const map = {};
                this.filteredLessons.forEach(
                    e => (map[e.timeDate.substr(0, 10)] = map[e.timeDate.substr(0, 10)] || [])
                        .push(e));
                return map;
            },
            lessonsMapMonthlyGrouped() {
                const map = {};
                this.filteredLessons.forEach(
                    e => (map[e.timeDate.substr(0, 7)] = map[e.timeDate.substr(0, 7)] || [])
                        .sort(this.compare)
                        .push(e));
                return map;
            },
            startMonth() {
                return this.start.slice(0, 7)
            },
            currentMonth() {
                let monthNames = [
                    "January", "February", "March",
                    "April", "May", "June", "July",
                    "August", "September", "October",
                    "November", "December"
                ];
                let date = new Date(this.start);
                let monthIndex = date.getMonth();
                let year = date.getFullYear();
                return monthNames[monthIndex] + ' ' + year;
            }
        },
        methods: {
            loadAdditional(id) {
                let self = this;
                axios.get(this.$store.state.apiServer + '/api/schedule/' + id)
                    .then(function (response) {
                        self.lessons = response.data;
                        self.lessons.forEach(function (one) {
                            one.open = false;
                        })
                    })
                    .catch(function (error) {
                        console.log(error);
                        if (error.response != null && error.response.status == 400)
                            self.$router.push('/404');
                        // self.errorAutoClosable(error.response.data);
                    });
                axios.get(this.$store.state.apiServer + '/api/users/get-all-trainers')
                    .then(function (response) {
                        self.allTrainers = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                        if (error.response != null && error.response.status == 400)
                            self.$router.push('/404');
                        // self.errorAutoClosable(error.response.data);
                    });
                axios.get(this.$store.state.apiServer + '/api/attachments/all/' + id)
                    .then(function (response) {
                        self.allAttachments = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                        if (error.response != null && error.response.status == 400)
                            self.$router.push('/404');
                        // self.errorAutoClosable(error.response.data);
                    });
            },
            goToGroupPage() {
                this.$router.push('/groups/' + this.group.id);
            },
            successAutoClosable(title) {
                this.$snotify.success(title, {
                    timeout: 2000,
                    showProgressBar: false,
                    closeOnClick: false,
                    pauseOnHover: true
                });
            },
            errorAutoClosable(title) {
                this.$snotify.error(title, {
                    timeout: 2000,
                    showProgressBar: false,
                    closeOnClick: false,
                    pauseOnHover: true
                });
            },
            editLesson(lesson) {
                this.currentEditingLesson = Object.assign({}, lesson);
                this.editing = true;
                window.scrollTo(0, document.body.scrollHeight);
            },
            addLesson() {
                this.editing = true;
                this.currentEditingLesson =
                    {
                        "id": null,
                        "topic": "",
                        "groupId": this.$route.params.id,
                        "trainerId": this.courseTrainerId,
                        "timeDate": new Date().toISOString(),
                        "attachments": [],
                        "isCanceled": false,
                        "duration": '01:00',
                        isNew: true,
                        "isPerformed": false,
                    };
                window.scrollTo(0, document.body.scrollHeight);
            },
            cancelLesson(lesson) {
                let self = this;
                axios.post(this.$store.state.apiServer + '/api/schedule/' + lesson.id)
                    .then(function (response) {
                        lesson.isCanceled = response.data;
                        lesson.open = false;
                        if (lesson.isCanceled) self.successAutoClosable('Lesson has been canceled');
                        else self.successAutoClosable('Lesson has been activated');
                    })
                    .catch(function (error) {
                        console.log(error);
                        self.errorAutoClosable(error.response.data);
                        console.log(error.response.data);
                    });
            },
            deleteLesson(lesson) {
                let self = this;
                axios.delete(this.$store.state.apiServer + '/api/schedule/' + lesson.id)
                    .then(function (response) {
                        self.lessons = self.lessons.filter(el => el.id !== lesson.id);
                        self.cancel();
                        self.successAutoClosable('Lesson has been archived');

                    })
                    .catch(function (error) {
                        console.log(error);
                        self.errorAutoClosable(error.response.data);
                    });
            },
            save(newLesson) {
                let self = this;
                if (newLesson.isNew) {
                    axios.post(this.$store.state.apiServer + '/api/schedule/new', newLesson)
                        .then(function (response) {
                            self.lessons = self.lessons.filter(el => el.id !== newLesson.id);
                            newLesson.id = response.data;
                            newLesson.open = false;
                            self.lessons.push(newLesson);
                            self.cancel();
                            self.successAutoClosable('New lesson has been added');
                            newLesson.isNew = false;
                        })
                        .catch(function (error) {
                            console.log(error);
                            self.errorAutoClosable(error.response.data);
                        });
                } else {
                    axios.post(this.$store.state.apiServer + '/api/schedule', newLesson)
                        .then(function (response) {
                            self.lessons = self.lessons.filter(el => el.id !== newLesson.id);
                            newLesson.id = response.data;
                            newLesson.open = false;
                            self.lessons.push(newLesson);
                            self.cancel();
                            self.successAutoClosable('Lesson has been updated');
                        })
                        .catch(function (error) {
                            console.log(error);
                            self.errorAutoClosable(error.response.data);
                        });
                }

            },
            cancel() {
                this.currentEditingLesson = null;
                this.editing = false;
            },
            getDate(strDate) {
                return new Date(strDate).toDateString().slice(0, 20);
            },
            compare(aa, bb) {
                let a = new Date(aa.timeDate);
                let b = new Date(bb.timeDate);
                return (
                    isFinite(a = this.convert(a).valueOf()) &&
                    isFinite(b = this.convert(b).valueOf()) ?
                        (a > b) - (a < b) : NaN
                );
            },
            convert(d) {
                return (
                    d.constructor === Date ? d :
                        d.constructor === Array ? new Date(d[0], d[1], d[2]) :
                            d.constructor === Number ? new Date(d) :
                                d.constructor === String ? new Date(d) :
                                    typeof d === "object" ? new Date(d.year, d.month, d.date) :
                                        NaN
                );
            },
            computedTime(time) {
                let [hours, minutes] = time.split(':');
                let modifier = +hours < 12 ? 'am' : 'pm';
                hours = +hours % 12 || 12;
                minutes = +minutes === 0 ? '' : `:${minutes}`;
                return hours + minutes + modifier
            },
            forwardToLessonPage(id) {
                this.$router.push('/lessons/' + id)
            },
            userCanEdit(lesson) {
                return (this.$store.state.user.id == lesson.trainerId) || (this.$store.state.user.roles.includes('ADMIN'))
                    || (this.$store.state.user.id == this.courseTrainerId)
            },
            userCanAddLesson() {
                return (this.$store.state.user.roles.includes('ADMIN')) ||
                    (this.$store.state.user.id == this.courseTrainerId);
            }
        },
        components: {
            LessonEditingComponent
        }
    }
</script>

<style scoped>
    .my-lesson {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        border-radius: 2px;
        color: #ffffff;
        width: 100%;
        font-size: 12px;
        padding: 3px;
        cursor: pointer;
        margin-bottom: 1px;
    }

    /*noinspection ALL*/
    .active-lesson {
        background-color: #1867c0;
        border: 1px solid #1867c0;
    }

    /*noinspection ALL*/
    .canceled-lesson {
        background-color: #656266;
        border: 1px solid #656266;
    }

    .card {
        padding: 30px;
        margin-bottom: 30px;
        margin-top: 30px;
    }

    .title {
        color: white;
    }

</style>