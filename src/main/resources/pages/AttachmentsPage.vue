<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
    <v-container>
        <AttachmentUpload></AttachmentUpload>
        <v-layout row wrap>
            <v-flex xs12>
                <template>
                    <v-data-table
                            :headers="headers"
                            :items="attachments"
                            :expand="true"
                            item-key="id"
                    >
                        <template v-slot:items="props">
                            <tr>
                                <td class="my-link">
                                    <div>{{ props.item.url }}</div>
                                </td>
                                <td>
                                    <v-btn color="green" @click="downloadFile(props.item.id)">Download</v-btn>
                                </td>
                                <td>
                                    <v-btn color="error" @click="deleteFile(props.item.id)">Delete</v-btn>
                                </td>
                            </tr>
                        </template>
                    </v-data-table>
                </template>
            </v-flex>
        </v-layout>
    </v-container>
</template>


<script>
    import axios from 'axios';
    import AttachmentUpload from "../components/AttachmentUpload.vue";

    export default {
        name: "AttachmentsPage",
        data: function () {
            return {
                lessonId: null,
                fileId: null,
                attachments: [],
                headers: [
                    {
                        text: 'Name',
                        align: 'left',
                        value: 'title'
                    }
                ]
            }
        },
        components: {
            AttachmentUpload
        },
        mounted() {
            let self = this;
            axios.get(this.$store.state.apiServer + '/api/attachments/all')
                .then(function (response) {
                    self.attachments = response.data;
                })
                .catch(function (error) {
                    console.log(error);
                     if (error.response != null && error.response.status == 400)
                        self.$router.push('/404');
                });
        },
        methods: {
            uploadFile() {
                let form = new FormData(document.getElementById('uploadForm'));
                let imagefile = document.querySelector('#file');

                let request = new XMLHttpRequest();
                request.open('POST', this.$store.state.apiServer + '/api/attachments/upload-file');
                form.append('file', imagefile.files[0]);
                form.append('lessonId', this.lessonId);
                request.send(form);

            },
            downloadFile(id) {
                window.open(this.$store.state.apiServer + '/api/attachments/download/' + id);
            },

            deleteFile(fileId) {
                axios.delete(this.$store.state.apiServer + '/api/attachments/' + fileId)
                    .catch(function (error) {
                        console.log(error);
                    });

            }
        }
    }
</script>

<style scoped>

</style>